class LegalMailer < ActionMailer::Base
  default from: "noreply@uOttawa.ca"

  def account_approved(user)
    @user = user
    @user.update_attributes(activation_token: SecureRandom.urlsafe_base64)
    @activation_link = activate_session_url(token: @user.activation_token, only_path: false)

    mail(to: user.email, subject: "Activate your account")
  end

  def account_deleted(user)
    @user = user

    mail(to: user.email, subject: "Your OttawaU RSSP Account has been deleted")
  end
end
