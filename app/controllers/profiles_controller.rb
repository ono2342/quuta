# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit]

  # def show
  #   @user = User.find_by(nickname: params[:user_name])
  # end

  def edit; end
end
