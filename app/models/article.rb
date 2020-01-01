# frozen_string_literal: true

class Article < ApplicationRecord
  belongs_to :user
  has_many :likes
end
