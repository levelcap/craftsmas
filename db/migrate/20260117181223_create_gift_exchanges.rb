class CreateGiftExchanges < ActiveRecord::Migration[8.1]
  def change
    create_table :gift_exchanges do |t|
      t.string :name
      t.text :description
      t.integer :year
      t.date :event_date
      t.date :draw_date
      t.timestamps
    end
  end
end
