class GiftExchangeDraw < ApplicationRecord
  belongs_to :user
  belongs_to :giftee, class_name: "User", foreign_key: "giftee_id"
  belongs_to :gift_exchange
end
