require 'rails_helper'

RSpec.describe "旅行記投稿", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @map = FactoryBot.create(:map)
    @post = FactoryBot.build(:post)
    @post.images = fixture_file_upload("/files/test_image.jpg")
  end
  
  context '旅行記を投稿できる場合', js: true do
    it 'ログインしたユーザーは新規投稿できる' do
      #ログインする
      visit root_path
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      find('input[name = "commit"]').click
      expect(current_path).to eq root_path
      #googlemapのピンを1つクリックする
      find("map#gmimap10 area", visible: false).click
      visit "/maps/1"
      #ピンに書かれた島のリンクをクリックして各島の詳細ページへ遷移
      expect(current_path).to eq "/maps/1"
      #島の旅行記投稿ボタンをクリックする
      find('button[id = "openModal"]').click
      #content、evaluation_id、imagesを入力する
      fill_in 'post_content', with: @post.content
      find("option[value = '2']").click
      attach_file("post_image","spec/fixtures/files/test_image.jpg")
      #"SEND"ボタンを押し、Postモデルのレコードが1増える
      expect{find('input[name ="commit1"]').click}.to change {Post.count}.by(1)
      # モーダルが閉じ、島の詳細ページへ戻る
      expect(current_path).to eq '/maps/1'
      #投稿したcontentとevaluation_idがあることを確認
      expect(page).to have_content(@post.content)
      expect(page).to have_content(@post.evaluation_id)
      #投稿したimagesがあることを確認
      expect(page).to have_css('.images')
    end
  end
  context '旅行記を投稿できない場合', js: true do
    it 'ログインしていないユーザーは投稿できない' do
      #トップページに遷移
      visit root_path
      #島の詳細ページへ遷移
      find("map#gmimap10 area", visible: false).click
      visit "/maps/1"
      #ログイン画面にいることを確認
      expect(current_path).to eq new_user_session_path
    end
  end
end
