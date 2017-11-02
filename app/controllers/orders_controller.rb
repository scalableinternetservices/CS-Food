class OrdersController < ApplicationController

  def index
    @orders = Order.where("deliverer_id IS NULL")
  end

  # Show all the orders that are not fulfilled
  def show_all
    @order = Order.all
  end

  # Show only one order
  def show
    @order = Order.find(params[:id])
  end

  # Shows only current user's order
  def myorders
    @orders = current_user.orders
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
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

  private
  def order_params
    params.require(:order).permit(:title, :text)
  end
end
