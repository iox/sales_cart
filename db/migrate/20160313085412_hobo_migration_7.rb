class HoboMigration7 < ActiveRecord::Migration
  def self.up
    rename_column :product_types, :icon_color, :color_for_icon

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    rename_column :product_types, :color_for_icon, :icon_color

    change_column :users, :administrator, :boolean, default: false
  end
end
