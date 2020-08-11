class StaticPagesController < ApplicationController
  skip_authorization_check # CanCanCan

  def home
    @page_title = 'Barrio Electrico'
  end

end
