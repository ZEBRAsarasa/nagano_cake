class Order < ApplicationRecord

  belongs_to :customer

  has_many :order_details, dependent: :destroy

  enum payment_method: {
    credit: 0, #クレジットカード
    bank: 1 #銀行振込
  }

  enum order_status: {
    入金待ち: 0, #入金待ち
    入金確認: 1,  #入金確認
    製作中: 2, #製作中
    発送準備中: 3,  #発送準備中
    発送済み: 4  #発送済み
  }

  validates :postal_code, presence: true
  validates :address,     presence: true
  validates :name,        presence: true





end
