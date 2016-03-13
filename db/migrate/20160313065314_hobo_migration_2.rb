class HoboMigration2 < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.date     :expiration_date
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :purchase_id
      t.integer  :product_type_id
    end
    add_index :items, [:purchase_id]
    add_index :items, [:product_type_id]

    create_table :purchases do |t|
      t.date     :purchase_date
      t.datetime :created_at
      t.datetime :updated_at
    end

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    change_column :users, :administrator, :boolean, default: false

    drop_table :items
    drop_table :purchases
  end
end
