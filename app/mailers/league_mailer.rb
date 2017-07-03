class LeagueMailer < BaseMailer

  def welcome(league, locale)
    I18n.with_locale(locale) do
      mandrill_mail({
        template: "kicker-app-registration-#{locale}",
        subject: I18n.t('league_mailer.welcome.subject'),
        to: league.contact_email,
        bcc: 'kicker@railslove.com',
        vars: {
          'LEAGUE_NAME': league.name.capitalize
        },
        important: true
      })
    end
  end
end
