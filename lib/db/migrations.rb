require_relative 'connection'

class CreatePricesTable < ActiveRecord::Migration
  def up
    create_table :prices do |t|
      t.string :offer_id, null: false
      t.integer :price, null: false
      t.date :date, null: false
    end
    add_index :prices, [:offer_id, :date], unique: true
  end

  def down
    drop_table :stats
  end
end

begin
  CreatePricesTable.migrate(:up)
rescue
end
