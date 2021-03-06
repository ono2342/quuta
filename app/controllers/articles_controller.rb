# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit]
  before_action :authenticate_user!, except: %i[show search]

  def new
    unless current_user.nickname.present?
      redirect_to setting_account_path(current_user), notice: '記事を投稿するにはユーザー名が必要です。'
    end
    @article = Article.new
  end

  def search
    redirect_to root_path if params[:q].nil?
    @search_word = params[:q]
    @search_word_array = params[:q].split(/[\p{blank}\s]+/)
    @search = Article.ransack(title_or_text_cont_any: @search_word_array)
    @search.sorts = 'id desc'
    @articles = @search.result.page(params[:page]).per(15)
    @favorites = Favorite.where(user: current_user).pluck('article_id')
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
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
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

  def edit
    article = Article.find(params[:id])
    if article.user_id != current_user.id
      redirect_to action: 'show', id: params[:id]
    end
  end

  def update
    article = Article.find(params[:id])
    if article.user_id == current_user.id
      article.update(article_params)
      redirect_to action: 'show', id: params[:id]
    else
      redirect_to action: 'show', id: params[:id]
    end
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy if article.user_id == current_user.id
  end

  def comment_destroy
    comment = Comment.find(params[:comment_id])
    comment.destroy if comment.user_id == current_user.id
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
