class LeadsController < ApplicationController
  include Effective::CrudController
  page_title ::I18n.t("lead page"), only: [:new]

  def resource_redirect_path(action)
    root_path
  end

  def resource_flash(status, *args)
    if status == :success
      I18n.t(:success_lead_submission)
    else
      super
    end
  end
end
