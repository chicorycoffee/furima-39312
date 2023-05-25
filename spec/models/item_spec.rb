require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '商品が保存できる場合' do
      it '必要な情報が入力されれば保存できる' do
        expect(@item).to be_valid
      end
    end

    context '商品が保存できない場合' do
      it '商品画像が空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end

      it '商品名が空では保存できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it '商品の説明が空では保存できない' do
        @item.info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'カテゴリーの情報が初期値では保存できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを選んでください")
      end

      it '商品の状態の情報が初期値では保存できない' do
        @item.sales_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を選んでください")
      end

      it '配送料の負担の情報が初期値では保存できない' do
        @item.shipping_fee_status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を選んでください")
      end

      it '発送元の地域の情報が初期値では保存できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を選んでください")
      end

      it '発送までの日数の情報が初期値では保存できない' do
        @item.scheduled_delivery_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を選んでください")
      end

      it '価格の情報が空では保存できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end

      it '価格が299円以下では保存できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字で、￥300〜￥9,999,999の間で設定してください')
      end

      it '価格が10000000円以上では保存できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字で、￥300〜￥9,999,999の間で設定してください')
      end

      it '価格が全角数字では保存できない' do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字で、￥300〜￥9,999,999の間で設定してください')
      end

      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
