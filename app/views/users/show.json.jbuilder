# frozen_string_literal: true

json.call(@user, :name, :quota, :image, :number_of_wins, :number_of_losses)
json.percentage @user.win_percentage
