class CreateGiftExchangeDraws < ActiveRecord::Migration[8.1]
  def change
    create_table :gift_exchange_draws do |t|
      t.timestamps
    end
    add_reference :gift_exchange_draws, :gift_exchange, foreign_key: true
    add_reference :gift_exchange_draws, :user, foreign_key: true
    add_reference :gift_exchange_draws, :giftee, foreign_key: { to_table: :users }
  end
end
