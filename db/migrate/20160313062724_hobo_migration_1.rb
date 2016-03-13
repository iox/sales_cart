class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :product_types do |t|
      t.string   :name
      t.decimal  :sell_price, :precision => 8, :scale => 2
      t.decimal  :purchase_price, :precision => 8, :scale => 2
      t.datetime :created_at
      t.datetime :updated_at
    end

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    change_column :users, :administrator, :boolean, default: false

    drop_table :product_types
  end
end
