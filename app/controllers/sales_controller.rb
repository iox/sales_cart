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
      format.text { render csv: @search.result }
    end
  end

end
