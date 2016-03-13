class HoboMigration5 < ActiveRecord::Migration
  def self.up
    add_column :product_types, :material_icon, :string
    add_column :product_types, :icon_color, :string

    change_column :users, :administrator, :boolean, :default => false
  end

  def self.down
    remove_column :product_types, :material_icon
    remove_column :product_types, :icon_color

    change_column :users, :administrator, :boolean, default: false
  end
end
