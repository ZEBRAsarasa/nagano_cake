class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
    @order_detail = OrderDetail.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order.id), notice: "注文ステータスを更新しました。"
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end

end
