class Inquiry
  include ActiveModel::Model

  attr_accessor :name, :email, :message
  
  VALID_EMAIL_REGIX    = /\A[^@\s]+@[^@\s]+\z/
  validates :name,       presence: { message: "名前を入力してください" }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGIX,   message: "フォーマットが不適切です"}
end
