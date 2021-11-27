class Public::CartItemsController < ApplicationController

  def index
    @cart_items = current_customer.cart_items.all
    @tax = Tax
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path, notice: "商品の個数を変更しました。"
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path, notice: "カート内にあった商品を一つ削除しました。"
  end

  def all_delete
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to cart_items_path, notice: "カート内にあった商品をすべて削除しました。"
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_items = current_customer.cart_items
    @cart_item.customer_id = current_customer.id
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).blank?
      @cart_item.amount = params[:cart_item][:amount]
      @cart_item.save
      redirect_to cart_items_path
    else
      redirect_to item_path(params[:cart_item][:item_id]), notice: "すでに商品が追加されています。"
    end


  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :customer_id, :item_id)
  end

end
