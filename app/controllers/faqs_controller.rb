class FaqsController < ApplicationController
  include Effective::CrudController
  page_title 'FAQs', only: [:index, :show]

  before_render(only: :index) do
    if current_user
      resource.response_email = current_user.email
    end
  end


  #WHY THE HELL IS faqs_path mapping to show? something to do with locale?
  def show
    index
    render :index
    return false
    #redirect_to faqs_path
  end
  submit :increment, "SHOULD NOT BE VISIBLE", except: [:index, :new, :show, :create]
end
