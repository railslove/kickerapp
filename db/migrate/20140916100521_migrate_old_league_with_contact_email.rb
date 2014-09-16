class MigrateOldLeagueWithContactEmail < ActiveRecord::Migration
  def change
    League.all.each do |league|
      league.contact_email = league.users.reorder(:id).first.try(:email) || ''
      league.save
    end
  end
end
