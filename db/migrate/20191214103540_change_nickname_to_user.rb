# frozen_string_literal: true

class ChangeNicknameToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :nickname, :string, null: true
  end
end
