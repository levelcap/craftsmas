class GiftExchangesController < ApplicationController
  def new
    @gift_exchange = GiftExchange.new
  end

  def create
    @gift_exchange = GiftExchange.new(blessed_params)
    if @gift_exchange.save
      redirect_to root_url, :notice => "Gift Exchange created"
    else
      render "new"
    end
  end

  # TODO: Handle cases where you've exhausted the match list for a user before reaching them
  def draw
    gift_exchange = GiftExchange.find(params[:id])
    user_ids = gift_exchange.users.map(&:id)
    already_matched_user_ids = []

    user_ids.each do |user_id|
      draw = GiftExchangeDraw.new(gift_exchange:, user_id:)
      matched_id = potential_match_user_ids.sample
      draw.giftee_id = matched_id
      already_matched_user_ids << matched_id
      draw.save!
    end
  end

  private

  def blessed_params
    params.expect(gift_exchange: [ :description, :name, :draw_date, :event_date, :year ])
  end

  # TODO: Create and use explicit exclude lists
  # Create the remaining list of user IDs for a potential user
  def potential_match_user_ids(users_ids:, already_matched_ids: [], user_id:)
    user_ids - (already_matched_user_ids << user_id).uniq
  end
end
