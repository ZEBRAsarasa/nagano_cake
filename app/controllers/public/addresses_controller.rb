class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @addresses = Address.all
    @address = Address.new(address_params)
    if @address.save
     redirect_to addresses_path
    else
     render:index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
     redirect_to address_path
    else
     render:edit
    end
  end

  def destroy
  end

  private
  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
