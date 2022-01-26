class ContactsController < ApplicationController
  #お問い合わせ送信機能
  def new
    @contact = Contact.new
  end

  # メールを送信&データベースに保存
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to done_path
    else
      redirect_to new_contact_path
    end
  end

  # メール送信確認画面
  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end

  # 入力内容に誤りがあった場合、入力内容を保持したまま前のページに戻る
  def back
    @contact = Contact.new(contact_params)
    render :new
  end

  # お問い合わせ完了ページ
  def done
  end

  private

  def contact_params
    params.require(:contact).permit(:email,:name,:message)
  end
end
