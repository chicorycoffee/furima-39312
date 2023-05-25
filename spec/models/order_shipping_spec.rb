require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  describe '購入情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_shipping = FactoryBot.build(:order_shipping, user_id: user.id, item_id: item.id)
    end

    context '購入情報が保存できる場合' do
      it '必要な情報が入力されれば保存できること' do
        expect(@order_shipping).to be_valid
      end

      it '建物名は空でも保存できること' do
        @order_shipping.building = ''
        expect(@order_shipping).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it '郵便番号が空では保存できないこと' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("郵便番号を入力してください")
      end

      it '郵便番号が「3桁+ハイフン+4桁」の半角文字列でないと保存できないこと' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('郵便番号はすべて半角で、3桁と4桁をハイフン(-)で区切って入力してください')
      end

      it '都道府県の情報が初期値では保存できないこと' do
        @order_shipping.prefecture_id = 1
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('都道府県を選んでください')
      end

      it '市区町村が空では保存できないこと' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("市区町村を入力してください")
      end

      it '番地が空では保存できないこと' do
        @order_shipping.addresses = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("番地を入力してください")
      end

      it '電話番号が空では保存できないこと' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("電話番号を入力してください")
      end

      it '電話番号が10桁以上11桁以内の半角数値でなければ保存できないこと' do
        @order_shipping.phone_number = '090-1234-5678'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は半角数字で、ハイフン(-)無しで10桁または11桁で入力してください')
      end

      it '電話番号が9桁以下では保存できないこと' do
        @order_shipping.phone_number = '090123456'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は半角数字で、ハイフン(-)無しで10桁または11桁で入力してください')
      end

      it '電話番号が12桁以上では保存できないこと' do
        @order_shipping.phone_number = '090123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は半角数字で、ハイフン(-)無しで10桁または11桁で入力してください')
      end

      it '電話番号に半角数字以外が含まれている場合は保存できないこと' do
        @order_shipping.phone_number = '０９０１２３４５６７８'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('電話番号は半角数字で、ハイフン(-)無しで10桁または11桁で入力してください')
      end

      it 'userが紐づいていない場合は保存できないこと' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Userを入力してください")
      end

      it 'itemが紐づいていない場合は保存できないこと' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Itemを入力してください")
      end

      it 'tokenが空では登録できないこと' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('クレジットカード情報を入力してください')
      end
    end
  end
end
