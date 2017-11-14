class OrdersController < ApplicationController

  # Only shows orders that are not fulfilled
  def index
    @orders = Order.where("deliverer_id IS NULL")
  end

  # Show all the orders that are not fulfilled (UNUSED)
  def show_all
    @order = Order.all
  end

  # Show only one order
  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def edit
    @order = Order.find(params[:id])
  end

  def create
    @order = current_user.orders.create(order_params)

    item_fields = %w(item_1 item_2 item_3 item_4 item_5)
    items = []
    item_fields.each do |item_name|
      text_field_name = item_name + '_text'
      items << (params['order'][item_name].size > params['order'][text_field_name].size ?
          params['order'][item_name] : params['order'][text_field_name])
    end

    items.each do |item|
      @order.items << Item.find_or_create_by(name: item) if item.size > 0
    end

    if @order.save
      points_difference = current_user.points - @order.points
      current_user.update_attribute(:points, points_difference)
      redirect_to @order
    else
      render 'new'
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.deliverer_id != nil
      flash[:alert] = "Can't do that"
    elsif @order.update(order_params)
    else
      render 'edit'
    end
    redirect_to @order
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

  # Shows only current user's order
  def myorders
    @orders = current_user.orders.where(delivered_at: nil)
  end

  def mypicks
    @orders = Order.where(deliverer_id: current_user.id, delivered_at: nil)
  end

  # Optimistic update
  def pick
    @order = Order.find(params[:id])
    @order.deliverer_id = current_user.id
    @order.save
    redirect_to action: "index"
  end

  def myhistory
    @my_orders = Order.where(user_id: current_user.id).where("delivered_at IS NOT NULL")
    @my_picks = Order.where(deliverer_id: current_user.id).where("delivered_at IS NOT NULL")

  def receive
    @order = Order.find(params[:id])
    @order.delivered_at = Time.now.getutc
    @order.save
    redirect_to myorders_orders_path
  end

  private
  def order_params
    params.require(:order).permit(:title, :text, :points)
  end
end
