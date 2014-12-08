class Match < ActiveRecord::Base

  belongs_to :winner_team, class_name: "Team"
  belongs_to :loser_team, class_name: "Team"

  belongs_to :league, counter_cache: true

  default_scope lambda {order("date DESC")}

  validates :winner_team, presence: true
  validates :loser_team, presence: true
  validate :team_players_validation

  after_create :calculate_user_quotas

  scope :for_team, lambda { |team_id| where("(winner_team_id = #{team_id} OR loser_team_id = #{team_id})")}
  scope :wins_for_team, lambda { |team_id| where("winner_team_id = #{team_id}")}
  scope :losses_for_team, lambda { |team_id| where("loser_team_id = #{team_id}")}


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
    winner_team.users.map(&:id).include?(user.id)
  end

  def winner_team?(team)
    winner_team_id == team.id
  end

  def opponent_team(team)
    winner_team == team ? loser_team : winner_team
  end

  def calculate_user_quotas
    quota_change = QuotaCalculator.elo_quota(winner_team.elo_quota, loser_team.elo_quota , 1 )

    if self.crawling == true
      quota_change = quota_change + 5
    end

    self.difference = quota_change
    self.save

    self.users.each do |user|
      user.set_elo_quota(self)
    end

    winner_team.update_attributes(number_of_wins: winner_team.number_of_wins + 1)
    loser_team.update_attributes(number_of_losses: loser_team.number_of_losses + 1)
  end

  def revert_points
    winner_team.users.each do |winner|
      winner.update_attributes(quota: (winner.quota - self.difference))
    end
    winner_team.update_attributes(number_of_wins: winner_team.number_of_wins - 1)

    loser_team.users.each do |loser|
      loser.update_attributes(quota: (loser.quota + self.difference))
    end
    loser_team.update_attributes(number_of_losses: loser_team.number_of_losses - 1)
    self.save
  end

  def update_team_streaks
    [ winner_team, loser_team ].each do |team|
      team.users.each do |user|
        user.calculate_current_streak!
        user.calculate_longest_streak!
      end
    end
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
end
