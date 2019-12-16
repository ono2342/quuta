class ChangeTextToArticles < ActiveRecord::Migration[5.2]
  def up
    change_column :articles, :text, :text, null: false
  end

  def down
    change_column :articles, :text, :string
  end
end
