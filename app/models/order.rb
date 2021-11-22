class Order < ApplicationRecord

  belongs_to :customer

  has_many :order_details, dependent: :destroy

  enum payment_method: {
    credit: 0, #クレジットカード
    bank: 1 #銀行振込
  }

  enum order_status: {
    payment_waiting: 0, #入金待ち
    payment_confirmation: 1,  #入金確認
    in_production: 2, #製作中
    preparing_delivery: 3,  #発送準備中
    delivered: 4  #発送済み
  }

end
