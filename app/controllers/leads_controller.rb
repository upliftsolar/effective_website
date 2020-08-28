class LeadsController < ApplicationController
  include Effective::CrudController
  def new
    @page_title = t('create_lead_page_title', locale: @locale)
    super
  end

  def resource_redirect_path(action)
    root_path
  end

  def resource_flash(status, *args)
    if status == :success
      t(:success_lead_submission)
    else
      super
    end
  end
end
