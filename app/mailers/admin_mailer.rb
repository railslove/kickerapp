class AdminMailer < ApplicationMailer

  def new_league(league_id)
    @league = League.find(league_id)
    mail from: 'app@kicker.cool', to: 'kicker@railslove.com', subject: t('emails.admin_mailer.new_league.subject', name: @league.name, slug: @league.slug)
  end

end
