class Admin::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_detail.update(order_detail_params)
    if @order_detail.production_status == "製作中"
      @order = @order_detail.order
      @order.update(order_status: "製作中")
    end
    # @total = 0
    # @order.order_details.each do |order_detail|
    #   if order_detail.production_status == "製作完了"
    #     @total += 1
    #   end
    # end
    # if @total == @order.order_details.count
    #   @order.update(order_status: "発送準備中")
    # end
    if @order.order_details.where(production_status: "製作完了").count  == @order.order_details.count
      @order.update(order_status: "発送準備中")
    end
    redirect_to admin_order_path(@order), notice: "製作ステータスを更新しました。"
  end

  private
  def order_detail_params
    params.require(:order_detail).permit(:production_status)
  end

end
