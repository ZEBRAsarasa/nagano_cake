class OrderDetail < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum production_status: {
    start_not_possible: 0,  #着手不可
    production_pending: 1,  #製作待ち
    in_production: 2, #製作中
    production_complete: 3  #製作完了
  }

end
