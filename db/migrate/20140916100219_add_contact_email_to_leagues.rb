# frozen_string_literal: true

class AddContactEmailToLeagues < ActiveRecord::Migration[4.2]
  def change
    add_column :leagues, :contact_email, :string
  end
end
