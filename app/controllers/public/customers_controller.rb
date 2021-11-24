class Public::CustomersController < ApplicationController

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
    # redirect_to customer_path unless current_customer.id == @customer.id
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
  end

  def cancel
    @customer = Customer.find(params[:id])
  end

  def cancel_do
    @customer = Customer.find(params[:id])
    redirect_to customer_path unless current_customer.id == @customer.id
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,
                                      :postal_code, :address, :telephone_number, :email, :is_deleted)
  end

end
