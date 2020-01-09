# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :set_array, only: %i[edit update]
  before_action :search_profile
  before_action :sidebar_setting, except:[:edit,:update]

  def show
    @user = User.find_by(nickname: params[:user_name])
    if @user.blank?
      render template: "errors/error_404"
    end
    @relation = Relation.find_by(user: current_user, follower_id: @user)
    @favorite = Favorite.where(user: current_user)
    @favorites = []
    @favorite.each do |favorite|
      @favorites << favorite.article_id
    end
    @articles = Article.where(user:@user)
    @articles = Article.page(params[:page]).per(15).order(created_at: "DESC")
  end

  def likes
  end

  def comments
  end

  def follows 
  end

  def followers
  end
  
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

  def sidebar_setting
    @menulist = ["投稿した記事", "いいねした記事", "コメント", "フォロー", "フォロワー"]
    @linklist = ["/profile/#{params[:user_name]}/posts", "/profile/#{params[:user_name]}/likes", "/profile/#{params[:user_name]}/comments", "/profile/#{params[:user_name]}/follows", "/profile/#{params[:user_name]}/followers"]
  end
end
