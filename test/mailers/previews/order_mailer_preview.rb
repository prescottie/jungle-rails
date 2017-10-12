class OrderMailerPreview < ActionMailer::Preview
  def order_email
      OrderMailer.order_email(Order.last, email = 'test@test.com')
  end
end