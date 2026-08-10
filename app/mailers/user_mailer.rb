class UserMailer < ApplicationMailer
  # It me!
  default from: "cohen.davids@gmail.com"

  def invite_email
    @user = params[:user]
    @url  = "https://craftsmas.onrender.com"
    mail(to: @user.email, subject: "Eyyy its a Craftsmas!")
  end
end
