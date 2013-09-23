class Team < ActiveRecord::Base
  has_many :matches
  belongs_to :player1, class_name: "User"
  belongs_to :player2, class_name: "User"

  scope :for_users, lambda { |user1_id, user2_id| where("(player1_id = #{user1_id} OR player2_id = #{user1_id}) AND (player1_id = #{user2_id} OR player2_id = #{user2_id})")}

  def self.find_or_create(user_ids)
    users = User.where(id: user_ids)
    team = nil
    team = Team.for_users(user_ids.first, user_ids.last).first
    if team.nil? && users.size == 2
      team = Team.new
      team.player1_id = user_ids.first
      team.player2_id = user_ids.last
      team.save
    end
    team
  end

  def users
    [player1, player2].compact
  end

  private


end
