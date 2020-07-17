class ApplicationMailer < ActionMailer::Base
  default from:     "自分",
          bcc:      "sent@gmail.com",
          reply_to: "reply@gmail.com"
  layout 'mailer'
end
