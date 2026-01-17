class GiftExchangeUser < ApplicationRecord
  belongs_to :user
  belongs_to :gift_exchange
end
