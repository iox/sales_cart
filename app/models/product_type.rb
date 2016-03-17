class ProductType < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name           :string
    public_price   :decimal, :precision => 8, :scale => 2
    material_icon  :string
    color_for_icon :string
    timestamps
  end
  attr_accessible :name, :public_price, :material_icon, :color_for_icon

  has_many :items

  def available_count
    items.available.count
  end

  def sold_count
    items.sold.count
  end

  def out_of_stock?
    available_count < 1
  end

  def color_for_icon
    out_of_stock? ? 'grey' : super
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
