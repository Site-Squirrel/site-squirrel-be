module Email

  from = SendGrid::Email.new(email: 'test@example.com')
  to = SendGrid::Email.new(email: 'menyeart1@gmail.com')
  subject = 'Sending with Twilio SendGrid is Fun'
  content = SendGrid::Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
  @@mail = SendGrid::Mail.new(from, subject, to, content)

  def send_email
  sg = SendGrid::API.new(api_key: ENV['TWIL_KEY'])
  response = sg.client.mail._('send').post(request_body: @@mail.to_json)
  binding.pry
  end
end
