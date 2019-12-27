# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!

  def edit
    @email = if current_user.email.include?('twitter@example.com')
               nil
             else
               current_user.email
    end
  end

  def update
    @user.update_attributes(user_params)
    if @user.save
      @user.update_attributes(icon: nil) if params[:user][:icon].nil?
      redirect_to controller: :users, action: :edit
    else
      render :edit
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email, :nickname, :icon)
  end
end
