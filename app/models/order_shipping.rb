class OrderShipping
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number, :item_id, :user_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はすべて半角で、3桁と4桁をハイフン(-)で区切って入力してください' }
    validates :city
    validates :addresses
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は半角数字で、ハイフン(-)無しで10桁または11桁で入力してください' }
    validates :user_id
    validates :item_id
    validates :token
  end
  validates :prefecture_id, numericality: { other_than: 1, message: "を選んでください" }

  def save
    order = Order.create(item_id: item_id, user_id: user_id)
    Shipping.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city, addresses: addresses, building: building,
                    phone_number: phone_number, order_id: order.id)
  end
end
