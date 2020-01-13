# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = Favorite.where(user: current_user).order(id: 'DESC')
    @favorites_article = @favorites.pluck('article_id')
    @articles = Article.where(id: @favorites_article).order(['field(`id`, ?)', @favorites_article]).page(params[:page]).per(15)
  end

  def create
    @article = Article.find(params[:article_id])
    Favorite.create(user: current_user, article: @article)
  end

  def delete
    if @favorite = Favorite.find_by(user: current_user, article: params[:article_id])
      @favorite.delete
    end
  end
end
