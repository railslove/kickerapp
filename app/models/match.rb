class Match < ActiveRecord::Base

  belongs_to :winner_team, class_name: "Team"
  belongs_to :looser_team, class_name: "Team"

  default_scope lambda {order("date DESC")}

  after_create :calculate_user_quotes

  scope :for_team, lambda { |team_id| where("(winner_team_id = #{team_id} OR looser_team_id = #{team_id})")}


  def self.create_from_set(set_params)
    winner_score = max_score(set_params)
    looser_score = min_score(set_params)
    winner_team = Team.find_or_create(user_ids_for_score(set_params, winner_score))
    looser_team = Team.find_or_create(user_ids_for_score(set_params, looser_score))
    match = Match.new(winner_team: winner_team, looser_team: looser_team, date: Time.now)
    match.score = match.score_for_set(winner_score, looser_score)
    match.crawling = match.crawling_for_set(set_params)
    match.save ? match : nil
  end

  def win_for?(user)
    winner_team.users.map(&:id).include?(user.id)
  end

  def calculate_user_quotes
    quote_change = QuoteCalculator.elo_quote(winner_team.elo_quote, looser_team.elo_quote , 1 )
    if self.crawling == true
      quote_change = quote_change + 5
    end

    self.difference = quote_change
    self.save

    self.winner.each do |winner|
      winner.quote = winner.quote + quote_change
      winner.number_of_wins += 1
      winner.save
    end

    self.looser.each do |looser|
      looser.quote = looser.quote - quote_change
      looser.number_of_looses += 1
      looser.save
    end

    winner_team.update_attributes(number_of_wins: winner_team.number_of_wins + 1)
    looser_team.update_attributes(number_of_looses: looser_team.number_of_looses + 1)
  end

  def revert_points
    winner_team.users.each do |winner|
      winner.update_attributes(quote: (winner.quote - self.difference))
    end
    winner_team.update_attributes(number_of_wins: winner_team.number_of_wins - 1)

    looser_team.users.each do |looser|
      looser.update_attributes(quote: (looser.quote + self.difference))
    end
    looser_team.update_attributes(number_of_looses: looser_team.number_of_looses - 1)
    self.save
  end

  def swap_teams
    old_winner = self.winner_team
    self.winner_team = self.looser_team
    self.looser_team = old_winner
  end

  def users
    winner_team.users + looser_team.users
  end

  def score_for_set(winner_score, looser_score)
    "#{winner_score}:#{looser_score}"
  end

  def crawling_for_set(set_params)
    set_params[:crawling]
  end

  # For Rss

  def title
    "#{winner_team.name} vs. #{looser_team.name}"
  end

  def content
    c = "Klare Angelegenheit. "
    c += self.score
    c += " Es wurde gekrabbelt!" if self.crawling.present?
    c
  end

  def winner
    self.winner_team.users
  end


  def looser
    self.looser_team.users
  end

  private

  def self.max_score(set_params)
    set_params.values.select{|v|v.is_a?(Integer)}.max
  end

  def self.min_score(set_params)
    set_params.values.select{|v|v.is_a?(Integer)}.min
  end

  def self.user_ids_for_score(set_params, select_score)
    set_params.select{|user_id, score| score == select_score }.keys
  end
end
