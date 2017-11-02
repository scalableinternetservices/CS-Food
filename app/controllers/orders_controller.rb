class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @order = Order.new
  end

  def edit

    @order = current_user.orders.find_by_id(params[:id])

    if @order == nil
      render 'page_fault'
    end

  end

  def create
    @order = current_user.orders.create(order_params)
     
    if @order.save
      redirect_to @order
    else
      render 'new'
    end

  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      redirect_to @order
    else
      render 'edit'
    end
  end

  def destroy
    @order = current_user.orders.find_by_id(params[:id])

    if @order == nil
      render 'page_fault'
    else
      @order.destroy
      redirect_to orders_path
    end
  end

  private
  def order_params
    params.require(:order).permit(:title, :text)
  end
end
