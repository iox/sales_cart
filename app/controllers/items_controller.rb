class ItemsController < ApplicationController

  hobo_model_controller

  auto_actions :read_only

  def index
    params[:q] = Hash.new if !params[:q]

    # Workaround for bug in Hobo metasearch, clear the key in the search hash if it's empty or nil
    if params[:q] && params[:q][:product_type_id_eq].blank?
      params[:q].delete(:product_type_id_eq)
    end

    @search = Item.search(params[:q])
    @items = @search.result.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.text { render csv: @search.result }
    end
  end

end
