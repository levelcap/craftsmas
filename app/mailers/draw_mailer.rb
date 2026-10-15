class DrawMailer < ApplicationMailer
  def draw_email
    match = params[:match]
    users = params[:users]
    gifter = match[:giter]
    giftee = match[:giftee]
    match = users.select do |user|
      user[:email] == giftee
    end.first

    @gifter = users.select do |user|
      user[:email] == giftee
    end.first

    @match_name = match[:name]
    @questions = match[:questions]
    @other = match[:other]

    mail(to: "cohen.davids@gmail.com", subject: "Your Craftsmas Match is Here!")
  end
end
