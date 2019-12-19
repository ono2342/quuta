# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @user = User.find_by(nickname: params[:user_name])
  end
end
