class PurchasesController < ApplicationController

  hobo_model_controller

  auto_actions :all

  def index
    @purchases = Purchase.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.text { render csv: Purchase.all }
    end
  end

end
