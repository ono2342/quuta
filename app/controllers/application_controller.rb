# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search_params_set
  before_action :store_location

 private 

  def store_location
    if (request.fullpath != login_path &&
        request.fullpath != signout_path &&
        request.fullpath != signup_path &&
        !request.xhr?)
      session[:previous_url] = request.fullpath 
    end
  end

  def after_sign_in_path_for(resource)
    if (session[:previous_url] == root_path)
      super
    else
      session[:previous_url] || root_path
    end
  end

  def after_sign_out_path_for(resource)
    login_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:login])
  end

  def search_params_set
    @q = Article.ransack(params[:q])
    @articles = @q.result(distinct: true)
  end
end
