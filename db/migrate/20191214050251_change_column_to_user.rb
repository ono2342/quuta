# frozen_string_literal: true

class ChangeColumnToUser < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :nickname, :string, null: false
    add_index :users, :nickname, unique: true
  end

  def down
    change_column :users, :nickname, :string
  end
end
