# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :firstname
      t.string :lastname
      t.string :email_status
      t.string :team
      t.string :position
      t.string :batting
      t.string :throwing
      t.text :description
      t.string :twitter
      t.string :facebook

      t.timestamps
    end
  end
end
