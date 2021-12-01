class Public::OrdersController < ApplicationController



  def new
    @order = Order.new
    @customer = current_customer
    if !current_customer.cart_items.exists?
      redirect_to cart_items_path, notice: "カート内に商品がありません。"
    end
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

    elsif params[:order][:address_option] == "2"
      if params[:order][:address_id] == ""
        flash.now[:alert] = '住所が選択されていません。'
        render:new
      else
        @address = Address.find(params[:order][:address_id].to_i)
        @order.address = @address.address
        @order.postal_code = @address.postal_code
        @order.name = @address.name
      end
    elsif params[:order][:address_option] == "3"
      if params[:order][:address] == "" || params[:order][:postal_code] == "" || params[:order][:name] == ""
        flash.now[:alert] = '住所、郵便番号、宛名いずれかが入力されていません。'
        render:new
      end
    else
      flash.now[:alert] = 'お届け先が選択されていません。'
      render:new
    end
  end

  def create
    @order = Order.new(order_params)
    if @order.save
      @cart_items = current_customer.cart_items.all
      @tax = Tax
      @cart_items.each do |cart_item|
        @order_detail = OrderDetail.new
        @order_detail.item_id = cart_item.item_id
        @order_detail.amount = cart_item.amount
        @order_detail.price_including_tax = cart_item.item.price_excluding_tax*@tax
        @order_detail.order_id = @order.id
        @order_detail.save!
      end
      @cart_items.destroy_all
      redirect_to orders_thanks_path
    else
      render:new
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order  = Order.find(params[:id])
    @order_details = OrderDetail.all
  end

  private
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :order_status, :customer_id)
  end

end
