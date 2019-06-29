class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  # GET /stocks.json
  def index
    if params[:search].present?
      identifier = params['search'].values.first.upcase
      @stocks = Stock.fetch(identifier)
      flash.now.alert = 'Stock not found. Try MSFT or AAPL for more success!' if @stocks.empty?
    end
  end

  # POST /stocks
  # POST /stocks.json
  def create
    if params[:commit].present?
      identifier = params['add'].values.first.upcase
      @stock = Stock.fetch(identifier).first
      UserStock.create!(user: current_user, stock: @stock)
      flash.now.notice = 'Stock added'
      render :index
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    UserStock.where(user_id: current_user.id, stock_id: params[:id]).delete_all
    flash.now.notice = 'Stock removed'
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:identifier, :description, :last_price, :last_price, :current_price, :current_price)
    end
end
