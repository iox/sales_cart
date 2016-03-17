class HoboMigration8 < ActiveRecord::Migration
  def self.up
    change_column :users, :administrator, :boolean, :default => false

    add_column :sales, :name, :string
  end

  def self.down
    change_column :users, :administrator, :boolean, default: false

    remove_column :sales, :name
  end
end
