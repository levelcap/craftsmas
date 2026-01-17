class CreateWishlists < ActiveRecord::Migration[8.1]
  def change
    create_table :wishlists do |t|
      t.timestamps
    end
    add_reference :wishlists, :user, index: true
  end
end
