class ItemsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name, :info, :prefecture_id, :category_id, :shipping_fee_status_id,
                                 :scheduled_delivery_id, :sales_status_id, :price, :image).merge(user_id: current_user.id)
  end
end
