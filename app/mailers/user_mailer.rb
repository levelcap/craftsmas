class UserMailer < ApplicationMailer
  def invite_email
    @user = params[:user]
    @url  = "https://craftsmas.onrender.com"
    mail(to: 'cohen.davids@gmail.com', subject: "Eyyy its a Craftsmas!")
  end

  def draw_email(match:, users:)
    gifter = match[:giter]
    giftee = match[:giftee]
    match = users.select do |user|
      user[:email] == giftee
    end.first

    @gifter = users.select do |user|
      user[:email] == giftee
    end.first

    @match_name = match[:name]
    @match_questions = match[:questions]
    @match_other = match[:other]

    mail(to: 'cohen.davids@gmail.com', subject: "Your Craftsmas Match is Here!")
  end
end
