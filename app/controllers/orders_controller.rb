class OrdersController < ApplicationController

  # Optimistic update
  def pick
    @order = Order.find(params[:id])
    @order.deliverer_id = current_user.id
    @order.save
    redirect_to action: "index"
  end

  # Only shows orders that are not fulfilled
  def index
    @orders = Order.where("deliverer_id IS NULL")
  end

  # Show all the orders that are not fulfilled, IS THIS USED?
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

  def destroy
    @order = Order.find(params[:id])
    if @order.deliverer_id == nil
      @order.destroy
    else
      flash[:alert] = "Can't do that"
    end
    redirect_to params[:continue_to] || orders_path
  end

  private
  def order_params
    params.require(:order).permit(:title, :text)
  end
end
