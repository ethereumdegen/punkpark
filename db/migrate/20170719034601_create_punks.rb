class CreatePunks < ActiveRecord::Migration
  def change
    create_table :punks do |t|
      t.string :avatar
      t.string :owner_eth_address
      t.timestamps null: false
    end
  end
end
