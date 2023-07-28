module Email
  def send_email(to, subject, email_text)
    from = SendGrid::Email.new(email: 'menyeart22@turing.edu')
    to = SendGrid::Email.new(email: to)
    content = SendGrid::Content.new(type: 'text/plain', value: email_text)

    mail = SendGrid::Mail.new(from, subject, to, content)
    sg = SendGrid::API.new(api_key: ENV['SEND_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
