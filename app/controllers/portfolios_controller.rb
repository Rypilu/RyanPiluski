class PortfoliosController < ApplicationController

  def index
    @portfolio_items = Portfolio.all
  end

  def new
    @portfolio_item = Portfolio.new
  end

  def create
    @portfolio_item = Portfolio.new(params.require(:portfolio).permit(:title,:subtitle,:body))
    # @portfolio_item = Portfolio.new(params.require(:portfolio).permit(:title, :subtitle, :body))

    respond_to do |format|
      if @portfolio_item.save
        format.html { redirect_to portfolios_path, notice: "Your portfolio item is now live." }
        format.json { render :show, status: :created, location: @portfolio_item }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @portfolio_item = Portfolio.find(params[:id])
  end

  def update
    @portfolio_item = Portfolio.find(params[:id])

    respond_to do |format|
      if @portfolio_item.update(params.require(:portfolio).permit(:title,:subtitle,:body))
        format.html { redirect_to portfolios_path, notice: "Your portfolio has been updated" }
        format.json { render :show, status: :ok, location: @portfolio_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @portfolio_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @portfolio_item = Portfolio.find(params[:id])
  end

  def destroy
    # Perform lookup
    @portfolio_item = Portfolio.find(params[:id])

    # Destroy / delete record
    @portfolio_item.destroy

    # Redirect
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: "Record #{@portfolio_item.title} was removed." }
      format.json { head :no_content }
    end
  end

end
