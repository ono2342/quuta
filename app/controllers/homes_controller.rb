# frozen_string_literal: true

class HomesController < ApplicationController
  def index
    @user = User.new
    @articles = Article.order(updated_at: 'DESC').limit(15)
  end
end
