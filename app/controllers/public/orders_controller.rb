class Public::OrdersController < ApplicationController



  def new
    @order = Order.new
    @customer = current_customer

  end

  def confirm
    @tax = Tax
    @shipping_cost = ShippingCost
    @cart_items = current_customer.cart_items.all

    @order = Order.new(order_params)
    if params[:order][:address_option] == 1
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
      @order.save(order_params)
      redirect_to orders_confirm_path
    elsif params[:order][:address_option] == 2
      @address = Address.find(params[:id])
      @order.address = @address.address
      @order.postal_code = @address.postal_code
      @order.name = @address.name
      @order.save
      redirect_to orders_confirm_path
    elsif params[:order][:address_option] ==3
      @order.save
      redirect_to order_confirm_path
    end

  end

  def create
    @order = Order.new
    @order.shipping_cost = ShippingCost
    @order.total_payment = @total_payment
    if @order.save(order_params)
      redirect_to orders_confirm
    else
      render:new
    end
  end

  def thanks
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :order_status, :customer_id)
  end

end
