class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @tax = Tax
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item.find(params[:id])
    @cart_item.delete
  end

  def all_delete
    @cart_items = CartItem.all
    @cart_items.delete
    redirect_to cart_items_path, notice: "カート内にあった商品をすべて削除しました。"
  end

  def create
    @cart_item = CartItem.new
    @cart_item.save(cart_item_params)
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :customer_id, :item_id)
  end

end
