class Public::AddressesController < ApplicationController

  def index
    @addresses = current_customer.addresses.all
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @addresses = Address.all
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
     redirect_to addresses_path, notice: "配送先を新しく追加しました。"
    else
     render:index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
     redirect_to addresses_path
    else
     render:edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path, notice: "配送先を削除しました。"
  end

  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
