# frozen_string_literal: true

class ProfilesController < ApplicationController
  before_action :authenticate_user!, only: [:edit]
  before_action :set_array, only: %i[edit update]
  before_action :search_profile
  before_action :set_variable_for_profile, except: %i[edit update]

  def posts
    @articles = Article.where(user: @user).page(params[:page]).per(15).order(created_at: 'DESC')
  end

  def likes
    @likes_articles = Like.where(user: @user).order(created_at: 'DESC').pluck('article_id')
    @articles = Article.where(id: @likes_articles).order(['field(`id`, ?)', @likes_articles]).page(params[:page]).per(15)
  end

  def comments
    @comments = Comment.where(user: @user).order(created_at: 'DESC').page(params[:page]).per(15)
  end

  def follows
    @follows = @user.followings.order(created_at: 'DESC').page(params[:page]).per(15)
  end

  def followers
    @followers = @user.followers.order(created_at: 'DESC').page(params[:page]).per(15)
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

  def set_variable_for_profile
    @user = User.find_by(nickname: params[:user_name])
    render template: 'errors/error_404' if @user.blank?
    @relation = Relation.find_by(user: current_user, follower_id: @user)
    @favorites = Favorite.where(user: current_user).pluck('article_id')
  end

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
