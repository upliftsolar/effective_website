class Admin::FaqsController < Admin::ApplicationController
  include Effective::CrudController
  page_title 'FAQs', only: [:index, :show]


  #WHY THE HELL IS faqs_path mapping to show? something to do with locale?
  def show
    index
    render :index
    return false
    #redirect_to faqs_path
  end

  submit :increment, "SHOULD NOT BE VISIBLE", except: [:index, :new, :edit, :show]
end
