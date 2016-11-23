class Match < ActiveRecord::Base

  belongs_to :winner_team, class_name: "Team"
  belongs_to :loser_team, class_name: "Team"

  belongs_to :league, counter_cache: true

  default_scope lambda {order("date DESC")}

  validates :winner_team, presence: true
  validates :loser_team, presence: true
  validate :team_players_validation

  before_create :calc_difference
  before_update :calc_difference

  after_create :update_stats
  after_update :update_stats
  after_destroy :update_stats

  scope :by_date, -> date { where("date::timestamp::date = ?", date) }
  scope :for_team, lambda { |team_id| where("(winner_team_id = #{team_id} OR loser_team_id = #{team_id})")}
  scope :wins_for_team, lambda { |team_id| where("winner_team_id = #{team_id}")}
  scope :losses_for_team, lambda { |team_id| where("loser_team_id = #{team_id}")}
  scope :including_teams, -> { includes(loser_team: [:player1, :player2], winner_team: [:player1, :player2]) }
  scope :by_user, -> id {
    joins('LEFT JOIN teams ON (matches.winner_team_id = teams.id OR matches.loser_team_id = teams.id)')
    .where('teams.player1_id = :id OR teams.player2_id = :id', id: id)
  }
  scope :lost_by, -> id { joins(:loser_team).where('teams.player1_id = :id OR teams.player2_id = :id', id: id) }
  scope :won_by, -> id { joins(:winner_team).where('teams.player1_id = :id OR teams.player2_id = :id', id: id) }

  after_commit :publish_created_notification, on: :create
  after_commit :publish_updated_notification, on: :update

  def self.create_from_set(set_params)
    set_params[:score] = set_params[:score].map(&:to_i)
    winner_score = set_params[:score].max
    loser_score = set_params[:score].min
    winner_team = Team.find_or_create(user_ids_for_score(set_params, winner_score))
    loser_team = Team.find_or_create(user_ids_for_score(set_params, loser_score))
    match = Match.new(winner_team: winner_team, loser_team: loser_team, date: Time.now, league_id: set_params[:league_id])
    match.score = match.score_for_set(winner_score, loser_score)
    match.crawling = match.crawling_for_set(set_params)
    match.save
    match
  end

  def win_for?(user)
    winner_team.user_ids.include?(user.id)
  end

  def winner_team?(team)
    winner_team_id == team.id
  end

  def opponent_team(team)
    winner_team == team ? loser_team : winner_team
  end

  def calc_difference
    quota_change = QuotaCalculator.elo_quota(winner_team.elo_quota, loser_team.elo_quota, 1)
    quota_change += 5 if crawling

    self.difference = quota_change
  end

  def update_stats
    update_user_stats
    update_team_stats
  end

  def update_user_stats
    users.each(&:update_stats)
  end

  def update_team_stats
    [winner_team, loser_team].each(&:update_stats)
  end

  def swap_teams
    old_winner = self.winner_team
    self.winner_team = self.loser_team
    self.loser_team = old_winner
  end

  def users
    winner_team.users + loser_team.users
  end

  def score_for_set(winner_score, loser_score)
    "#{winner_score}:#{loser_score}"
  end

  def crawling_for_set(set_params)
    set_params[:crawling]
  end

  def scores
    score.split(":").map(&:to_i)
  end

  def active_user_ranking
    league.users.reload.ranked.select(&:active?)
  end

  # For Rss

  def title
    "#{winner_team.name} vs. #{loser_team.name}"
  end

  def content
    CommentGenerator.random(self.scores.first, self.scores.last, self.crawling, (self.id % 3 == 0))
  end

  def winner
    self.winner_team.users
  end

  def loser
    self.loser_team.users
  end

  # Make stuff more attractive for displaying it

  def score_for_team(team)
    team ||= winner_team
    winner_team?(team) ? score : scores.reverse.join(':')
  end

  def signed_difference_for_team(team)
    team ||= winner_team
    winner_team?(team) ? difference : -1 * difference
  end

  def teams_with_primary_first(primary = nil)
    primary ||= winner_team
    [primary, opponent_team(primary)]
  end

  def teams
    teams_with_primary_first
  end

  private

  def self.user_ids_for_score(set_params, select_score)
    set_params["team#{ (set_params[:score].index(select_score)) + 1 }".to_sym].values.reject(&:blank?)
  end

  def team_players_validation
    if winner_team && loser_team && (winner_team.users - loser_team.users != winner_team.users)
      errors.add(:base, 'choose different players from each team')
    end
  end

  def publish_created_notification
    ActiveSupport::Notifications.publish('match:created', { record: self, status: :created })
  end

  def publish_updated_notification
    ActiveSupport::Notifications.publish('match:updated', { record: self, status: :updated })
  end
end
