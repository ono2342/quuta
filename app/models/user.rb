# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2], authentication_keys: [:login]
  after_create :create_profile
  mount_uploader :icon, ImageUploader

  # アソシエーション
  has_many :articles
  has_one :profile, dependent: :destroy
  has_many :relations, dependent: :destroy
  has_many :followings, through: :relations, source: :follower
  has_many :reverse_of_relations, class_name: 'Relation', foreign_key: 'follower_id'
  has_many :followers, through: :reverse_of_relations, source: :user
  has_many :likes
  has_many :comments
  has_many :favorites

  # バリデーション
  validates :nickname, presence: true, length: { maximum: 32 }, format: { with: /\A[-a-z]+\z/, message: 'は半角英字と「-」が使えます。' }, allow_blank: true, uniqueness: true, on: :create
  validates :nickname, presence: true, length: { maximum: 32 }, format: { with: /\A[-a-z]+\z/, message: 'は半角英字と「-」が使えます。' }, uniqueness: true, on: :update
  validates :email, presence: true, uniqueness: true
  validates :password, on: :create, presence: true, length: { in: 8..32 }, format: { with: /\A[a-zA-Z0-9!-~]+\z/, message: 'は8文字以上32文字以下で、半角英字、数字、記号が使えます。' }

  attr_accessor :login

  # nicknameでもemailでもログインできるように
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(['nickname = :value OR lower(email) = lower(:value)', { value: login }]).first
    else
      where(conditions).first
    end
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = if auth.provider == 'twitter'
                     "#{auth.uid}-#{auth.provider}@example.com"
                   else
                     auth.info.email
                   end
      user.password = Devise.friendly_token[0, 20]
    end
  end

  # ユーザー作成時に空のユーザープロフィールを作成
  def create_profile
    Profile.create(user_id: id)
  end
end
