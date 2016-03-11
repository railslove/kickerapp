# == Schema Information
#
# Table name: tournaments
#
#  id               :integer          not null, primary key
#  number_of_tables :integer
#  location         :string
#  name             :string

class Tournament < ActiveRecord::Base
  has_many :users
  has_many :new_matches

  def create_gameplan
    # Todo: Teams auslosen
    1.upto(number_of_matches) do |i|
      # Todo: Für number_of_matches/2 teams zuordnen
      new_matches.create(tournament_position: i, winner_next_match_position: calculate_winner_next_match_position(i), table_nr: calculate_table_nr(i))
    end
  end

  def number_of_matches
    # Todo Handle Freilose
    users.count / 2
  end

  private

  def calculate_table_nr(match_position)
    ((match_position - 1) % number_of_tables) + 1
  end

  def calculate_winner_next_match_position(match_position)
    if match_position < number_of_matches - 1
      (match_position / 2.0).round + (number_of_matches / 2)
    end
  end



end
