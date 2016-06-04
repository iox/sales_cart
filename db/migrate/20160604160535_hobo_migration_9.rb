class HoboMigration9 < ActiveRecord::Migration
  def self.up
    add_column :product_types, :vat, :boolean, :default => false

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :product_types, :vat

    change_column :users, :administrator, :boolean, default: false
  end
end
