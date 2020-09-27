
class LeadMailer < ApplicationMailer
  default from: ENV['WEBSITE_POSTMASTER_EMAIL']

  def new_activity_email(*args)
    @url  = 'http://example.com/login'
    mail(to: ENV['WEBSITE_POSTMASTER_EMAIL'], subject: "Lead submitted on #{ENV['WEBSITE_HUMAN_NAME']}")
  end
end