# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :set_array, only: %i[edit update]
  before_action :search_profile

  # def show
  #   @user = User.find_by(nickname: params[:user_name])
  # end

  def edit
    @email = if current_user.email.include?('twitter@example.com')
               nil
             else
               current_user.email
             end
  end

  def update
    @profile.update(profile_params)
    if @profile.save
      redirect_to controller: :profiles, action: :edit
    else
      render :edit
    end
  end

  private

  def search_profile
    @profile = Profile.find_by(user: current_user)
  end

  def set_array
    @positions = %w[ピッチャー キャッチャー ファースト セカンド サード ショート センター ライト レフト]
    @batting = %w[右打ち 左打ち 両打ち]
    @throwing = %w[右投げ 左投げ 両投げ]
  end

  def profile_params
    params.require(:profile).permit(:firstname, :lastname, :email_status, :team, :position, :batting, :throwing, :description, :twitter, :facebook)
  end
end
