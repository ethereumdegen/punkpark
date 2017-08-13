class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.string :eth_address, index:true
      t.datetime :last_signed_in

      t.timestamps
    end
  end
end
