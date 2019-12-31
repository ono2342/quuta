# frozen_string_literal: true

class RelationsController < ApplicationController
  def create
    if current_user.id != params[:user_id].to_i
      Relation.create(user: current_user, follower_id: params[:user_id])
    end
  end

  def delete
    if @relation = Relation.find_by(user: current_user, follower_id: params[:user_id])
      @relation.delete
    end
  end
end
