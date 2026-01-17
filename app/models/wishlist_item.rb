class WishlistItem < ApplicationRecord
  belongs_to :wishlist
  belongs_to :user, through: :wishlist
end
