class HoboMigration3 < ActiveRecord::Migration
  def self.up
    change_column :users, :administrator, :boolean, :default => false

    add_column :purchases, :total, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    change_column :users, :administrator, :boolean, default: false

    remove_column :purchases, :total
  end
end
