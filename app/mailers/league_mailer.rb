class LeagueMailer < BaseMailer

  def welcome(league, locale)
    I18n.with_locale(locale) do
      mandrill_mail({
        template: "#{ENV['game_type']}-app-registration-#{locale}",
        subject: I18n.t("league_mailer.welcome.#{game_type}.subject"),
        to: league.contact_email,
        bcc: 'kicker@railslove.com',
        vars: {
          'LEAGUE_NAME': league.name.capitalize,
          'LINK': league_url(league)
        },
        important: true
      })
    end
  end
end
