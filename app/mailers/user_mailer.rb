class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  #   # The generated User mailer.
  # def account_activation
  #   @greeting = "Hi"

  #   mail to: "to@example.org"
  # end
  
  # Mailing the account activation link.
  def account_activation(user)
    @user = user
    mail to: user.eamil, subject: "Account activation"
  end 


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset
    @greeting = "Hi"

    mail to: "to@example.org"
  end
end