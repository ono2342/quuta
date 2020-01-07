# frozen_string_literal: true

class HomesController < ApplicationController
  def index
    @user = User.new
  end
end
