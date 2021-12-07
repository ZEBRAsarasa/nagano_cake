class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
    @order_detail = OrderDetail.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    if @order.order_status == "入金確認"
      # @order_detail = @order.order_details
      # @order_detail.update(production_status: "製作待ち")
      @order.order_details.each do |f|
        f.update(production_status: "製作待ち")
      end
    end
    redirect_to admin_order_path(@order.id), notice: "注文ステータスを更新しました。"
  end

  private
  def order_params
    params.require(:order).permit(:order_status)
  end

end
