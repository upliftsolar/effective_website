class LeadsController < ApplicationController
  include Effective::CrudController
  after_action :send_activity_email, only: :create
  before_action :authorize_admin, except: [:create,:new]
  def new
    @page_title = t('create_lead_page_title', locale: @locale)
    super
  end

  def resource_redirect_path(action)
    root_path
  end

  def authorize_admin
    authorize!(:manage,Lead)
  end

  def send_activity_email
    LeadMailer.new_activity_email.deliver_later 
    #TODO: weekly https://guides.rubyonrails.org/action_mailer_basics.html
  end

  def resource_flash(status, *args)
    if status == :success
      t(:success_lead_submission)
    else
      super
    end
  end
end
