class ApplicationMailer < ActionMailer::Base
  default from: (ENV['TRANSACTION_EMAIL'] || 'barrioelectrico@gmail.com')

  layout 'mailer'

  def test_email
    mail(to: 'developer@example.com', subject: 'Active job and email systems functioning normally')
  end

  def test_exception
    raise 'this is an intention exception. An Active Job has raised this exception.'
  end

  def user_invited_to_community(user_id, community_id)
    @user = User.find_by_id(user_id)
    @community = Community.find_by_id(community_id)

    return false unless @user && @ommunity && @user.email

    mail(to: @user.email, subject: "Added to #{@community}")
  end

end
