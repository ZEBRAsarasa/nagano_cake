class ApplicationController < ActionController::Base
before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    items_path
  end

  protected

  def configure_permitted_parameters
    added_sttrs = [ :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_sttrs)
  end

  Tax = 1.1
  ShippingCost = 800

end
