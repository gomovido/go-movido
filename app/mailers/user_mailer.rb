class UserMailer < ApplicationMailer
  def welcome_email
    @user = User.find(params[:user_id])
    @locale = "en"
    mail(to: @user.email, subject: "✨ #{@user.first_name}, welcome to movido !")
  end

  def password_email
    @user = params[:user]
    @locale = "en"
    mail(to: @user.email, subject: "✨ #{@user.first_name}, your movido credentials")
  end

  def order_confirmed
    @user = User.find(params[:user_id])
    @order = Order.find(params[:order_id])
    @locale = "en"
    attachments["Movido_Starter_Pack_#{@user.first_name}_#{@user.last_name}_#{@order.created_at.strftime("%Y_%m_%d")}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(template: 'layouts/invoice_starter_pack.html.erb', pdf: "Movido_Starter_Pack_#{@user.first_name}_#{@user.last_name}_#{@order.created_at.strftime("%Y_%m_%d")}")
    )
    attachments["Movido_T&Cs_#{Time.now.year}.pdf"] = File.read('app/assets/files/movido_tc.pdf')
    mail(to: @user.email, subject: "✨ #{@user.first_name}, your Starter Pack is on its way !")
  end

  def contract_agreed
    @user = User.find(params[:user_id])
    @order = Order.find(params[:order_id])
    @locale = "en"
    attachments["Movido_Settle_In_Pack_#{@user.first_name}_#{@user.last_name}_#{@order.created_at.strftime("%Y_%m_%d")}.pdf"] = WickedPdf.new.pdf_from_string(
      render_to_string(template: 'layouts/invoice_settle_in_pack.html.erb', pdf: "Movido_Settle_In_Pack_#{@user.first_name}_#{@user.last_name}_#{@order.created_at.strftime("%Y_%m_%d")}")
    )
    attachments["Movido_T&Cs_#{Time.now.year}.pdf"] = File.read('app/assets/files/movido_tc.pdf')
    mail(to: @user.email, subject: "Your Movido Contract")
  end
end
