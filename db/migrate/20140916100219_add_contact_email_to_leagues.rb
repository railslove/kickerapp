# frozen_string_literal: true

class AddContactEmailToLeagues < ActiveRecord::Migration
  def change
    add_column :leagues, :contact_email, :string
  end
end
