class CreateWishlistItems < ActiveRecord::Migration[8.1]
  def change
    create_table :wishlist_items do |t|
      t.text :description
      t.timestamps
    end
    add_reference :wishlist_items, :wishlist, index: true
  end
end
