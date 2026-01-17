class GiftExchange < ApplicationRecord
  has_many :users, through: :gift_exchange_users
end
