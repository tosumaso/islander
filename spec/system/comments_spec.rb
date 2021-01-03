require 'rails_helper'

RSpec.describe "コメント投稿機能", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @map = FactoryBot.create(:map)
    @comment = FactoryBot.build(:comment)
  end

  context 'コメント投稿に成功する場合', js: true do
    it 'ログインしたユーザーは詳細ページでコメントを投稿できる' do
      #ログインする
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name = "commit"]').click
      expect(current_path).to eq root_path
      #島の詳細ページへ遷移
      find("map#gmimap10 area", visible: false).click
      visit "/maps/1"
      #コメント投稿フォームに情報を記載
      fill_in 'comment_content', with: @comment.content
      #投稿ボタンを押し、Commentモデルのレコードが1増える
      expect{find('input[name = "commit"]').click}.to change {Comment.count}.by(1)
      #投稿した内容がコメント欄に表示されている
      expect(page).to have_content(@comment.content)
    end 
  end
end
