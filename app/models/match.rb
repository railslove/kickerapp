class Match < ActiveRecord::Base

  belongs_to :winner_team, class_name: "Team"
  belongs_to :looser_team, class_name: "Team"

  def self.create_from_set(set_params)
    winner_score = max_score(set_params)
    looser_score = min_score(set_params)
    winner_team = Team.find_or_create(user_ids_for_score(set_params, winner_score))
    looser_team = Team.find_or_create(user_ids_for_score(set_params, looser_score))
    match = Match.new(winner_team: winner_team, looser_team: looser_team, date: Date.today)
    match.score = match.score_for_set(winner_score, looser_score)
    match.crawling = match.crawling_for_set(set_params)
    match.save ? match : nil
  end

  def score_for_set(winner_score, looser_score)
    "#{winner_score}:#{looser_score}"
  end

  def crawling_for_set(set_params)
    set_params[:crawling]
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
