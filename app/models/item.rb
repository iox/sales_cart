class Item < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    expiration_date :date
    sale_price   :decimal, :precision => 8, :scale => 2
    purchase_price :decimal, :precision => 8, :scale => 2
    timestamps
  end
  attr_accessible :expiration_date, :sale_price, :purchase_price, :purchase_id, :product_type_id, :purchase, :product_type, :amount, :sale, :sale_id

  belongs_to :purchase
  belongs_to :product_type
  belongs_to :sale


  scope :available, -> { where("sale_id IS NULL") }
  scope :sold, -> { where("sale_id IS NOT NULL") }

  def status
    sale_id ? 'sold' : 'available'
  end

  # Behaviour to allow creation of several items at the same time
  attr_accessor :amount
  after_create :clone_items_when_purchasing
  def clone_items_when_purchasing
    if self.amount.to_i > 1
      (self.amount.to_i-1).times do
        self.purchase.items << Item.new(
          product_type: self.product_type,
          expiration_date: self.expiration_date,
          purchase_price: self.purchase_price)
      end
    end
    self.purchase.update_total
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
