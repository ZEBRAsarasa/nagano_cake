class Public::OrdersController < ApplicationController



  def new
    @order = Order.new
    @customer = current_customer

  end

  def confirm
    @tax = Tax
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.shipping_cost = ShippingCost
    if params[:order][:address_option] == "1"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_option] == "3"
      @order.save
    elsif params[:order][:address_id] == ""
      flash.now[:alert] = '住所が選択されていません。'
      render:new
    elsif params[:order][:address_option] == "2"
      @address = Address.find(params[:order][:address_id].to_i)
      @order.address = @address.address
      @order.postal_code = @address.postal_code
      @order.name = @address.name
    elsif params[:order][:address] == "" || params[:order][:postal_code] == "" || params[:order][:name] == ""
      flash.now[:alert] = '住所、郵便番号、宛名いずれかが入力されていません。'
      render:new
    else
      flash.now[:alert] = 'お届け先が選択されていません。'
      render:new
    end
  end

  def create
    @order.address = current_customer.order.address
    @order.shipping_cost = ShippingCost
    @order.total_payment = @total_payment
    @order = Order.new(order_params)
    if @order.save

      # @cart_items = current_customer.cart_items.all
      # @cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      render:new
    end
  end

  def thanks
  end

  def index
    @orders = Order.all
  end

  def show
    @order  = Order.find(params[:id])
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :order_status, :customer_id)
  end

end
