# frozen_string_literal: true

class InquiryMailer < ApplicationMailer
  def received_email(inquiry)
    @inquiry = inquiry
    mail to: ENV['EMAIL_ADDRESS'], subject: 'メールのタイトル'
    # mail(:subject => 'お問い合わせを承りました')
  end
end
