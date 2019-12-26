class UsersController < ApplicationController
  def edit
    @user=current_user
    @email = if current_user.email.include?('twitter@example.com')
      nil
    else
      current_user.email
    end
  end

  def update
  end
end
