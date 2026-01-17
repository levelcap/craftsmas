class GiftExchangesController < ApplicationController
  def index
    @gift_exchanges = GiftExchange.all
  end

  def show
    @gift_exchange = GiftExchange.find(params[:id])
    @users = @gift_exchange.users
  end

  def new
    @gift_exchange = GiftExchange.new
  end

  def create
    @gift_exchange = GiftExchange.new(blessed_params)
    @gift_exchange.invite_code = @invite_code = SecureRandom.urlsafe_base64 8
    if @gift_exchange.save
      redirect_to gift_exchange_url(@gift_exchange.id), :notice => "Gift Exchange created"
    else
      render "new", :notice => "Gift Exchange Creation Failed"
    end
  end

  def join
    @gift_exchange = GiftExchange.find_by(invite_code: params[:invite_code])
    if session[:user_id].present?
      @gift_exchange.add_user(session[:user_id])
      return redirect_to gift_exchange_url(@gift_exchange.id)
    end
  end

  def add_user
    @gift_exchange = GiftExchange.find(params[:id])
    @user = User.find_by(email: params["email"])
    if @user.present?
      if @gift_exchange.user_joined?(@user.id)
        redirect_to gift_exchange_url(@gift_exchange.id), notice: "You already joined, here's the gift exchange!"
      else
        @gift_exchange.add_user(@user.id)
        redirect_to gift_exchange_url(@gift_exchange.id), notice: "You are READY TO CRAFT"
      end
    else
      @user = User.create(email: params["email"])
      @gift_exchange.add_user(@user.id)
      redirect_to gift_exchange_url(@gift_exchange.id), notice: "You are READY TO CRAFT and now have a user!"
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
