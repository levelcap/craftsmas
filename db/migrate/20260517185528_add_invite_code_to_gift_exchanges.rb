class AddInviteCodeToGiftExchanges < ActiveRecord::Migration[8.1]
  def change
    add_column :gift_exchanges, :invite_code, :string
  end
end
