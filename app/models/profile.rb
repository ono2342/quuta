class Profile < ApplicationRecord
  belongs_to :user

  validates :firstname, length: { maximum: 32 }
  validates :lastname, length: { maximum: 32 }
  validates :team, length: { maximum: 256}
  validates :description, length: { maximum: 500}
end
