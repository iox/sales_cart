class HoboMigration4 < ActiveRecord::Migration
  def self.up
    rename_column :product_types, :sell_price, :public_price
    remove_column :product_types, :purchase_price

    change_column :users, :administrator, :boolean, :default => false

    add_column :items, :sale_price, :decimal, :precision => 8, :scale => 2
    add_column :items, :purchase_price, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    rename_column :product_types, :public_price, :sell_price
    add_column :product_types, :purchase_price, :decimal, precision: 8, scale: 2

    change_column :users, :administrator, :boolean, default: false

    remove_column :items, :sale_price
    remove_column :items, :purchase_price
  end
end
