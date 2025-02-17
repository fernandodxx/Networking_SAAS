class ConnectionRequestMailer < ApplicationMailer
  def new_request_email(request)
    @receiver = request.receiver
    @sender = request.sender
    mail(to: @receiver.email, subject: "New Connection Request")
  end
end
