class PurchasesController < ApplicationController

  hobo_model_controller

  auto_actions :all, except: [:edit, :update]

  def index
    @purchases = Purchase.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.text { render csv: @purchases }
    end
  end

end
