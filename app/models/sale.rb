class Sale < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    sale_date :date
    total     :decimal
    timestamps
  end
  attr_accessible :sale_date, :total, :items

  has_many :items

  before_destroy :mark_items_as_available
  def mark_items_as_available
    items.update_all("sale_id = NULL")
  end

  def update_total
    update_attribute(:total, items.reload.sum(:sale_price))
  end

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end
