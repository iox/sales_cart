class Purchase < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    purchase_date :date, :required
    total :decimal, :precision => 8, :scale => 2
    timestamps
  end
  attr_accessible :purchase_date, :items

  has_many :items, :dependent => :destroy, :accessible => true

  def name
    "Purchase #{id}"
  end

  def update_total
    update_attribute(:total, items.reload.sum(:purchase_price))
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
