# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search_params_set

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
