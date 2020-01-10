# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :likes, foreign_key: :article_id, dependent: :destroy
  has_many :favorites, foreign_key: :article_id, dependent: :destroy
  has_many :comments, foreign_key: :article_id, dependent: :destroy
end
