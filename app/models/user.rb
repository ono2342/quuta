class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: { maximum: 32 },format: { with: /\A[-a-z]+\z/, message: "は半角英字と「-」のみで設定してください" }, allow_blank: true ,uniqueness: true
  validates :email, presence: true, uniqueness: true
end
