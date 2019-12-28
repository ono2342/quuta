class CreateRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :relations do |t|
      t.references :user, foreign_key: true
      t.references :follower, foreign_key: { to_table: :users }

      t.timestamps

      t.index [:user_id, :follower_id], unique: true
    end
  end
end
