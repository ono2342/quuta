# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :articles

  validates :nickname, presence: true, length: { maximum: 32 }, format: { with: /\A[-a-z]+\z/, message: 'は半角英字と「-」が使えます。' }, allow_blank: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 8..32 }, format: { with: /\A[a-zA-Z0-9!-~]+\z/, message: 'は8文字以上32文字以下で、半角英字、数字、記号が使えます。' }
end
