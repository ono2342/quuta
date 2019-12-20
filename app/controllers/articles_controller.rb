# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  def new
    @article = Article.new
  end

  def image
    image = Image.create(image_params)
    render json: { filename: image.image.url }
  end

  def create
    @article = Article.create(article_params)
  end

  def show; end

  private

  def article_params
    params.require(:article).permit(:title, :text).merge(user_id: current_user.id)
  end

  def set_article
    @article = Article.find(params[:id])
  end

  def image_params
    params.require(:images).permit(:image)
  end
end
