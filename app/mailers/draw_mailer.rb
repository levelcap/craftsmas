class DrawMailer < ApplicationMailer
  def draw_email
    match = params[:match]
    users = params[:users]
    gifter = match[:gifter]
    giftee = match[:giftee]

    # Create gift exchange draw record for posterity and debugging
    gifter_user = User.find_by(email: gifter)
    giftee_user = User.find_by(email: giftee)
    exchange = GiftExchange.find(1)
    GiftExchangeDraw.create(gift_exchange: exchange, user: gifter_user, giftee: giftee_user)

    match = users.select do |user|
      user[:email] == giftee
    end.first

    @gifter = users.select do |user|
      user[:email] == gifter
    end.first

    @match_name = match[:name]
    @questions = match[:questions]
    @other = match[:other]

    mail(to: "cohen.davids@gmail.com", subject: "Your Craftsmas Match is Here!")
  end
end
