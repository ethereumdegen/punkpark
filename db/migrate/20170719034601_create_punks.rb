class CreatePunks < ActiveRecord::Migration
  def change
    create_table :punks do |t|

      t.timestamps null: false
    end
  end
end
