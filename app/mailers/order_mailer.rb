class OrderMailer < ApplicationMailer
  default from: 'no-reply@jungle.com'

  def order_email(order, email)
    @order = order
    @email = email
    mail(to: @order.email, subject: "ORDER - #{@order.id}")
  end
end
