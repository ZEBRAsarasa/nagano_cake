class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
    # redirect_to customer_path unless current_customer.id == @customer.id
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_path
    else
      render:edit
    end
  end

  def cancel
    @customer = current_customer
  end

  def cancel_do
    @customer = current_customer
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,
                                      :postal_code, :address, :telephone_number, :email, :is_deleted)
  end

end
