class ApplicationMailer < ActionMailer::Base
  # default from: 'from@example.com'
  # The application mailer with a new default from address.
  default from: "noreply@example.com"
  layout 'mailer'
end
