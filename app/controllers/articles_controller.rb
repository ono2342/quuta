# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
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

  def image2_params
    params.permit(:image)
  end
end
