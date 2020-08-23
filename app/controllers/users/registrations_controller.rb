class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def create
    super do
      flash.now[:danger] = resource.errors.full_messages.to_sentence if resource.new_record?
    end
  end

  def update
    if params["confirm_locale"]
      #avoid allowing user to update their roles or permissions.
      #devise_parameter_sanitizer.permit(:update, keys: [:name, :email, :locale])
      user = current_user
      user.update_without_password(locale: params["confirm_locale"])
      if params["redirect_to"]
        redirect_to params["redirect_to"]
        return false
      end
    else
      super
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: User.permitted_sign_up_params)
  end

  def after_sign_up_path_for(user)
    session[:user_return_to] || root_path
  end


end
