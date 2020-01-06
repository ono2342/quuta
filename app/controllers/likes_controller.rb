# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @article = Article.find(params[:article_id])
    if current_user != @article.user
      Like.create(user: current_user, article: @article)
    end
  end

  def delete
    if @like = Like.find_by(user: current_user, article: params[:article_id])
      @like.delete
    end
  end
end
