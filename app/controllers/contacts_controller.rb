class ContactsController < ApplicationController
  #お問い合わせ送信機能
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to meals_path
    else
      redirect_to new_contact_path
    end
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :creste
    else
      render :new
    end
  end

  def back
    @contact = Contact.new(contact_params)
    render :new
  end

  def done
  end

  private

  def contact_params
    params.require(:contact).permit(:email,:name,:message)
  end
end
