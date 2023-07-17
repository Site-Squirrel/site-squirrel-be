module Twilio

  account_sid = ENV['TWIL_SID']
  auth_token = ENV['TWIL_KEY'] 
  @@client = Twilio::REST::Client.new(account_sid, auth_token)

  def send_sms(from_phone_number, to_phone_number, message)
    @@client.messages.create(
      from: from_phone_number,
      to: to_phone_number,
      body: message
    )
  end
end