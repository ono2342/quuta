# frozen_string_literal: true

class FavoritesController < ApplicationController
  before_action :authenticate_user!
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
