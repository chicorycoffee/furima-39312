require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nicknameとemail、passwordとpassword_confirmation、本人確認情報が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'abc12'
        @user.password_confirmation = 'abc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = 'abc1234'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'passwordが英数字でないと登録できない' do
        @user.password = 'あabc12'
        @user.password_confirmation = 'あabc12'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角の英字と数字の両方を含めて、6文字以上で設定してください')
      end

      it 'passwordが半角数字でないと登録できない' do
        @user.password = 'abc１２３'
        @user.password_confirmation = 'abc１２３'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角の英字と数字の両方を含めて、6文字以上で設定してください')
      end

      it 'passwordが半角英字でないと登録できない' do
        @user.password = 'ＡＢＣ123'
        @user.password_confirmation = 'ＡＢＣ123'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角の英字と数字の両方を含めて、6文字以上で設定してください')
      end

      it 'passwordが半角数字がないと登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角の英字と数字の両方を含めて、6文字以上で設定してください')
      end

      it 'passwordが半角数字のみの場合登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角の英字と数字の両方を含めて、6文字以上で設定してください')
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it '名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前の名字を入力してください')
      end

      it '名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前の名前を入力してください')
      end

      it '名字が全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前の名字は全角文字を使用してください')
      end

      it '名前が全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'rikutaro'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前の名前は全角文字を使用してください')
      end

      it '名字カナが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナの名字を入力してください")
      end

      it '名字カナが全角（カタカナ）でないと登録できない' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナの名字は全角カナを使用してください')
      end

      it '名前カナが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナの名前を入力してください')
      end

      it '名前カナが全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = 'りくたろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナの名前は全角カナを使用してください')
      end

      it '生年月日が空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
