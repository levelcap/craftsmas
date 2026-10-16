class DrawMailer < ApplicationMailer
  def draw_email
    match = params[:match]
    users = params[:users]
    gifter = match[:gifter]
    giftee = match[:giftee]
    match = users.select do |user|
      user[:email] == giftee
    end.first

    @gifter = users.select do |user|
      user[:email] == gifter
    end.first

    @match_name = match[:name]
    @questions = match[:questions]
    @other = match[:other]

    mail(to: "alissazimmer@gmail.com", subject: "Your Craftsmas Match is Here!")
  end
end
