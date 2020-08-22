class Admin::QuestionsController < Admin::ApplicationController
  include Effective::CrudController
  page_title 'FAQs', only: [:index, :show]

  def edit
    #binding.pry
    super
  end

  #WHY THE HELL IS faqs_path mapping to show? something to do with locale?
  def show
    index
    render :index
    return false
    #redirect_to faqs_path
  end
end
