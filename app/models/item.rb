class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :item_name, presence: true
  validates :info, presence: true
  validates :image, presence: true
  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, only_integer: true, message: 'は半角数字で、￥300〜￥9,999,999の間で設定してください' }

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :sales_status
  belongs_to :shipping_fee_status
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  validates :category_id, numericality: { other_than: 1, message: "を選んでください"}
  validates :sales_status_id, numericality: { other_than: 1, message: "を選んでください"}
  validates :shipping_fee_status_id, numericality: { other_than: 1, message: "を選んでください"}
  validates :prefecture_id, numericality: { other_than: 1, message: "を選んでください"}
  validates :scheduled_delivery_id, numericality: { other_than: 1, message: "を選んでください"}
end
