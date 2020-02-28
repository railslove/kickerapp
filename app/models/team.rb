# frozen_string_literal: true

class Team < ApplicationRecord
  belongs_to :player1, class_name: 'User', optional: true
  belongs_to :player2, class_name: 'User', optional: true

  belongs_to :league, optional: true

  validate :players_validation

  scope :for_user, ->(user1_id) { where("(player1_id = #{user1_id} OR player2_id = #{user1_id})") }
  scope :for_single_user, ->(user1_id) { where("(player1_id = #{user1_id} AND player2_id IS NULL)") }
  scope :for_doubles, -> { where('(player1_id IS NOT NULL AND player2_id IS NOT NULL)') }

  scope :for_users, ->(user1_id, user2_id) { where("(player1_id = #{user1_id} OR player2_id = #{user1_id}) AND (player1_id = #{user2_id} OR player2_id = #{user2_id})") }

  scope :ranked, -> { where('number_of_wins > 1 OR number_of_losses > 1') }

  def matches
    Match.for_team(id)
  end

  def wins
    Match.wins_for_team(id)
  end

  def losses
    Match.losses_for_team(id)
  end

  def partner_for(user)
    (users - [user]).first if users.include?(user)
  end

  def self.shuffle(user_ids)
    return [] unless user_ids.size == 4
    users = User.where(id: user_ids).order('quota desc')
    best_user = users.first
    users_to_select = []
    users[1..3].each_with_index do |user, index|
      (index + 1).times do
        users_to_select << user
      end
    end
    partner = users_to_select.sample
    opponents = users - [best_user, partner]
    [Team.find_or_create([best_user.id, partner.id]), Team.find_or_create([opponents.first.id, opponents.last.id])]
  end

  def self.find_or_create(user_ids)
    users = User.where(id: user_ids)
    team = nil
    if users.size > 1
      team = Team.for_users(user_ids.first, user_ids.last).first
    elsif !users.empty?
      team = Team.for_single_user(user_ids.first).first
    end
    if team.nil? && users.size == 2
      team = Team.new
      team.player1_id = user_ids.first
      team.player2_id = user_ids.last
      team.league = users.first.league
      team.save
    elsif team.nil? && users.size == 1
      team = Team.new
      team.player1_id = user_ids.first
      team.league = users.first.league
      team.save
    end
    team
  end

  def elo_quota
    users.present? ? (users.sum(&:quota).to_f / users.size).round : 1200
  end

  def users
    [player1, player2].compact
  end

  def user_ids
    [player1_id, player2_id]
  end

  def double?
    users.size > 1
  end

  def name
    users.map(&:name).join(' + ')
  end

  def short_name
    users.map(&:short_name).join(' + ')
  end

  # Use values from database if available, otherwise fetch data
  def number_of_games
    self['games_played'] || (number_of_wins + number_of_losses)
  end

  # Use values from database if available, otherwise fetch data
  def percentage
    wins = (self['games_won'] || number_of_wins).to_f
    played = self['games_played'] || number_of_games
    played > 0 ? (wins / played * 100).round : 0
  end

  def get_quota
    users.size > 1 ? quota : users.first.quota
  end

  # Use values from database if available, otherwise fetch data
  def value
    self['score'] || (League::BASE_SCORE + wins.sum(:difference) - losses.sum(:difference))
  end

  def add_win(difference)
    update_attributes(number_of_wins: number_of_wins + 1, quota: quota + difference)
  end

  def add_loss(difference)
    update_attributes(number_of_losses: number_of_losses + 1, quota: quota - difference)
  end

  private

  def players_validation
    if users.reject(&:blank?).count < 1
      errors.add(:base, 'team must have at least one player')
    end
  end
end
