class GiftExchange < ApplicationRecord
  generates_token_for :invite_code

  has_many :gift_exchange_users
  has_many :users, through: :gift_exchange_users

  def add_user(user_id)
    new_user = GiftExchangeUser.create(gift_exchange_id: self.id, user_id: user_id)
  end

  def user_joined?(user_id)
    return self.users.find_by(id: user_id).present?
  end
end
