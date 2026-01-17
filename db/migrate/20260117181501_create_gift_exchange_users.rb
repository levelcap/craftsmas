class CreateGiftExchangeUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :gift_exchange_users do |t|
      t.timestamps
    end
    add_reference :gift_exchange_users, :gift_exchange, foreign_key: true
    add_reference :gift_exchange_users, :user, foreign_key: true
  end
end
