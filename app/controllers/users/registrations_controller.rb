class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    super do
      flash.now[:danger] = resource.errors.full_messages.to_sentence if resource.new_record?
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: User.permitted_sign_up_params)
  end

  def after_sign_up_path_for(user)
    session[:user_return_to] || root_path
  end

  def update_resource(user_resource, params)
    #TODO: restrict to permitted
    if @confirm_locale
      #avoid allowing user to update their roles or permissions.
      #devise_parameter_sanitizer.permit(:update, keys: [:name, :email, :locale])
      user_resource.update_without_password(locale: @confirm_locale)
    else
      super
    end
  end
end
