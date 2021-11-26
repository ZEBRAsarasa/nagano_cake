class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    @genres = Genre.all
  end

  def show
    @genres = Genre.all
    @tax = Tax
    @item = Item.find(params[:id])

    # @cart_item = CartItem.new
    # @cart_item.save
    # redirect_to cart_items_path
  end

  
end
