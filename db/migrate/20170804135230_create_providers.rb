class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.integer :account_id,index:true
      t.string :name
      t.string :token
      t.datetime :authenticated_at

      t.timestamps
    end
  end
end
