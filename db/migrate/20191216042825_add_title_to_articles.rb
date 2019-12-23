# frozen_string_literal: true

class AddTitleToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :title, :string, null: false
    add_index :articles, :title
  end
end
