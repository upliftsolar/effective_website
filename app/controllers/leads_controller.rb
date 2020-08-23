class LeadsController < ApplicationController
  include Effective::CrudController
  page_title ::I18n.t("lead page"), only: [:new]

  def create
    r = super
    flash[:notice] = I18n.t(:success_lead_submission)
    #Redirect to?
    r
  end
end
