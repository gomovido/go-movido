class UserMailer < ApplicationMailer
  def welcome_email
    @user = User.find(params[:user_id])
    @locale = "en"
    mail(to: @user.email, subject: "✨ #{@user.first_name}, welcome to movido !")
  end

  def password_email
    @user = User.find(params[:user_id])
    @locale = "en"
    mail(to: @user.email, subject: "✨ #{@user.first_name}, your movido credentials")
  end

  def order_confirmed
    @user = User.find(params[:user_id])
    @locale = "en"
    @order = Order.find_by(user: @user)
    attachments["Movido_Starter_Pack_Invoice_#{@order.created_at.strftime("%Y_%m_%d")}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(template: 'layouts/invoice.html.erb', pdf: "Movido_Starter_Pack_Invoice_#{@order.created_at.strftime("%Y_%m_%d")}")
    )
    mail(to: @user.email, subject: "✨ #{@user.first_name}, your Starter Pack is on its way !")
  end

  def contract_agreed
    @user = User.find(params[:user_id])
    @order = Order.find(params[:order_id])
    @locale = "en"
    mail(to: @user.email, subject: "Your Movido Contract")
  end
end
