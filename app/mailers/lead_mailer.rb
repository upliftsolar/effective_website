
class LeadMailer < ApplicationMailer
  default from: ENV['WEBSITE_POSTMASTER_EMAIL']

  def new_activity_email(*args)
    @url  = "#{ENV['BASE_URL']}/login"
    mail(to: ENV['WEBSITE_POSTMASTER_EMAIL'], subject: "[#{ENV['WEBSITE_ABBREVIATION']}] Lead submitted on #{ENV['WEBSITE_HUMAN_NAME']}")
  end
end