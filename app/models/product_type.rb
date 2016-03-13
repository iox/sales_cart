class ProductType < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name           :string
    sell_price     :decimal, :precision => 8, :scale => 2
    purchase_price :decimal, :precision => 8, :scale => 2
    timestamps
  end
  attr_accessible :name, :sell_price, :purchase_price

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
