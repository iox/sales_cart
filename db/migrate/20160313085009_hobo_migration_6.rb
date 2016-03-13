class HoboMigration6 < ActiveRecord::Migration
  def self.up
    create_table :sales do |t|
      t.date     :sale_date
      t.decimal  :total
      t.datetime :created_at
      t.datetime :updated_at
    end

    change_column :users, :administrator, :boolean, :default => false

    add_column :items, :sale_id, :integer

    add_index :items, [:sale_id]
  end

  def self.down
    change_column :users, :administrator, :boolean, default: false

    remove_column :items, :sale_id

    drop_table :sales

    remove_index :items, :name => :index_items_on_sale_id rescue ActiveRecord::StatementInvalid
  end
end
