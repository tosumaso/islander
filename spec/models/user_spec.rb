require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー登録できる場合' do
      it 'name,email,password,password_confirmationが入力された場合' do
        expect(@user).to be_valid
      end
      it 'nameが10文字以内の場合' do
        @user.name = "test"
        expect(@user).to be_valid
      end
      it 'passwordが6文字以内かつ英数字混同の場合' do
        @user.password = "sample777"
        expect(@user).to be_valid
      end
    end
    context 'ユーザー登録できない場合' do
      it 'nameがない場合' do
        @user.name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名前が入力されていません。")
      end
      it 'emailがない場合' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("メールアドレスが入力されていません。")
      end
      it 'passwordがない場合' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードが入力されていません。")
      end
      it 'password_confirmationがない場合' do
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
      end
      it 'nameが10文字より長い場合' do
        @user.name = ("a" * 11)
        @user.valid?
        expect(@user.errors.full_messages).to include("名前は10文字以内で入力してください")
      end
      it '同じemailが既に存在する場合' do
        @user.save
        @user2 = FactoryBot.build(:user)
        @user2.valid?
        expect(@user2.errors.full_messages).to include("メールアドレスは既に使用されています。")
      end
      it 'passwordが５文字以下の場合' do
        @user.password = "test1"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上に設定して下さい。")
      end
      it 'passwordが英文字の身の場合' do
        @user.password = "aiueokakiku"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です。")
      end

      it 'passwordが数字のみの場合' do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です。")
      end
      it 'passwordが全角文字の場合' do
        @user.password = "あかさたなはま"
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です。")
      end
      it 'passwordとpassword_confirmationが一致しない場合' do
        @user.password = "test123"
        @user.valid?
        expect(@user.errors.full_messages).to include("確認用パスワードとパスワードの入力が一致しません")
      end
    end
  end
end
