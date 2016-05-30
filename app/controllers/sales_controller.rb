class SalesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def create
    rows = JSON.parse(params["rows"])
    if rows.size < 1
      render :json => { :errors => "You can't make an empty sale" }, :status => 422 and return
    end

    sale = Sale.create(:sale_date => Date.today)
    for row in rows
      item = Item.available.where(product_type_id: row["id"]).first
      if item
        item.update_attributes(sale_id: sale.id, sale_price: row["price"].to_i)
      else
        sale.destroy
        render :json => { :errors => "There are no available items for #{row['name']}" }, :status => 422 and return
      end
    end
    sale.update_total
    render :json => sale.reload
  end

  def index
    params[:q] = Hash.new if !params[:q]

    @search = Sale.search(params[:q])
    @sales = @search.result.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.text { prepare_text_table }
      format.csv { render csv: @search.result, filename: "EXPORT-SALES-#{I18n.l(Date.today, format: '%d.%m.%Y')}" }
    end
  end

  private

  def prepare_text_table
    # Prepare data: group items from the search results
    sold_items = []
    for sale in @search.result
      sold_items += sale.items.to_a
    end
    grouped_items = sold_items.group_by(&:product_type)

    # Table styling
    headings = ["Producttype", "Purchase Price", "Selling Price", "Count", "Total Purchase", "Total Selling"]
    style = {padding_left: 2, padding_right: 2}

    # Generate a text table
    @table = Terminal::Table.new :headings => headings, :style => style do |t|
      grouped_items.each do |product_type, items|
        t << [product_type.name, items.first.purchase_price, items.first.sale_price, items.size, items.sum(&:purchase_price), items.sum(&:sale_price)]
      end
      t << :separator
      t << ["Total", nil, nil, nil, sold_items.sum(&:purchase_price), sold_items.sum(&:sale_price)]
    end
    @table.align_column(1, :right)
    @table.align_column(2, :right)
    @table.align_column(3, :right)
    @table.align_column(4, :right)
    @table.align_column(5, :right)
  end

end
