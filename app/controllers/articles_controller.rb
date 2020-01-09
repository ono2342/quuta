# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :authenticate_user!, except: [:show]

  def new
    @article = Article.new
  end

  def image # 画像ドラッグドロップの処理
    image = Image.create(image_params)
    render json: { filename: image.image.url }
  end

  def image2 # 画像選択の処理
    @image = Image.create(image2_params)
    @image_url = @image.image
    render json: @image_url
  end

  def create
    @article = Article.create(article_params)
    redirect_to @article
  end

  def show
    @article = Article.find(params[:id])
    @relation = Relation.find_by(user: current_user, follower: @article.user)
    @like = Like.find_by(user: current_user, article: params[:id])
    @likes = Like.where(article: params[:id])
    @favorite = Favorite.find_by(user: current_user, article: params[:id])
  end

  def comment
    @comments = Comment.create(comment: params[:comment], article_id: params[:id], user_id: current_user.id)
    redirect_to action: 'show', id: params[:id]
  end

  private

  def article_params
    params.require(:article).permit(:title, :text).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.includes(:comments).find(params[:id])
  end

  def image_params
    params.require(:images).permit(:image)
  end

  def image2_params
    params.permit(:image)
  end

  def comment_params
    params.permit(:comment, :id)
  end
end
