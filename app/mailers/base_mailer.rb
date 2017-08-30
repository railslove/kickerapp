class BaseMailer < MandrillMailer::TemplateMailer
  include Rails.application.routes.url_helpers
  default from: 'kicker@railslove.com', from_name: "Railslove #{ENV['GAME_TYPE'].capitalize} App"
  # these will be used as default arguments to the mandrill_mail call
  # IMPORTANT: Read more about this method and its parameters when setting defaults or creating a new mailer
  # https://github.com/renz45/mandrill_mailer/#creating-a-new-mailer
  DEFAULT_ARGS = {
    important: false,
    inline_css: true
  }

  private

  def default_url_options
    ActionMailer::Base.default_url_options
  end

  def mandrill_mail(args)
    super(DEFAULT_ARGS.merge(args))
  end
end
