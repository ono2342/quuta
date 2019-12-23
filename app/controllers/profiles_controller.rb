# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :set_array, only:[:edit,:update]

  # def show
  #   @user = User.find_by(nickname: params[:user_name])
  # end

  def edit 
    @profile = Profile.find_by(user:current_user)
  end

  def update
    @profile = Profile.update(profile_params)
    render :edit
  end

  private

  def set_array
    @positions =["ピッチャー","キャッチャー","ファースト","セカンド","サード","ショート","センター","ライト","レフト"]
    @batting  =["右打ち","左打ち","両打ち"]
    @throwing  =["右投げ","左投げ","両投げ"]
  end
  
  def profile_params
    params.require(:profile).permit(:firstname, :lastname, :email_status, :team, :position, :batting, :throwing, :description, :twitter, :facebook)
  end
end
