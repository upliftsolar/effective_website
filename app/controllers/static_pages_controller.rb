class StaticPagesController < ApplicationController
  skip_authorization_check # CanCanCan

  def home
    @page_title = "#{ENV['WEBSITE_HUMAN_NAME'] || 'Example Website'}"
  end

end
