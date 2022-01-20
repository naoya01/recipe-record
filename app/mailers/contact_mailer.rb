class ContactMailer < ApplicationMailer
  #お問い合わせ用メーラー
  def send_mail(contact)
    @contact = contact
    mail to:   ENV['TOMAIL'], subject: '【お問い合わせ】'
  end
end
