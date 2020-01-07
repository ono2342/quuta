# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, only: [:create]
  prepend_before_action :customize_sign_up_params, only: [:create]

  def create
    @user = User.new(user_params)
    if @user.save!
      sign_in @user unless user_signed_in?
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def customize_sign_up_params
    devise_parameter_sanitizer.permit :sign_up, keys: %i[username email password password_confirmation remember_me]
  end

  def check_captcha
    self.resource = resource_class.new sign_up_params
    resource.validate
    unless verify_recaptcha(model: resource)
      respond_with_navigational(resource) { render :new }
    end
  end

  def user_params
    params.require(:user).permit(:nickname, :email, :password)
  end
end
