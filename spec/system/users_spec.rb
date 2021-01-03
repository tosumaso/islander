require 'rails_helper'

RSpec.describe "新規登録", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザー新規登録ができる場合' do
    it '正しい情報を入力して新規登録を行い、トップページに戻る' do
      # トップページへ遷移
      visit root_path
      # "新規登録"のボタンが存在する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ遷移
      visit new_user_registration_path
      # 各フォーム欄に適切なユーザー情報を入力する
      fill_in 'user_name', with: @user.name
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      fill_in 'user_password_confirmation', with: @user.password_confirmation
      # "登録"ボタンを押したらUserモデルのレコードが1増える
      expect{find('input[name = "commit"]').click}.to change {User.count}.by(1)
      # トップページへ自動で遷移
      expect(current_path).to eq root_path
      # ログインしたことにより"新規登録"、"ログイン"のボタンが表示されず、"ログアウト"のボタンが表示される。
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
      expect(page).to have_content('ログアウト')
    end
  end
  context 'ユーザー新規登録ができない場合' do
    it '誤った情報を入力して新規登録ページに戻る'do
      #トップページへ遷移
      visit root_path
      #"新規登録"ボタンが存在する
      expect(page).to have_content("新規登録")
      #新規登録ページへ遷移
      visit new_user_registration_path
      #各フォーム欄に誤ったユーザー情報を入力する
      fill_in 'user_name', with: ""
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      fill_in 'user_password_confirmation', with: ""
      #"登録"ボタンを押してもUserモデルのレコードが増えない
      expect{find('input[name = "commit"]').click}.to change {User.count}.by(0)
      #新規登録ページへ戻る
      expect(current_path).to eq "/users"
    end
  end
end

RSpec.describe "ログイン", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインできる場合' do
    it '正しい情報を入力すればログインできる' do
      #トップページへ遷移
      visit root_path
      #"ログイン"ボタンが存在する
      expect(page).to have_content("ログイン")
      #ログインページへ遷移
      visit new_user_session_path
      #各フォーム欄に適切な情報を入力する
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password      
      #ログインボタンを押す
      find('input[name = "commit"]').click
      #トップページへ自動で戻る
      expect(current_path).to eq root_path
      #ログインしたことにより"新規登録"ボタンと"ログイン"ボタンが表示されず、"ログアウト"のボタンが表示される
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
      expect(page).to have_content("ログアウト")
    end
  end
  context 'ログインできない場合' do
    it '誤った情報を入力してログインページへ戻る' do
      #トップページへ遷移
      visit root_path
      #"ログイン"ボタンが存在する
      expect(page).to have_content("ログイン")
      #ログインページへ遷移
      visit new_user_session_path
      #誤ったユーザー情報を入力する
      fill_in 'user_email', with: ""
      fill_in 'user_password', with: ""
      #ログインボタンを押す
      find('input[name = "commit"]').click
      #ログインページへ戻る
      expect(current_path).to eq "/users/sign_in"
    end
  end
end

RSpec.describe "ログアウト", type: :system do
  before do
    @user = FactoryBot.create(:user)
  end

  it 'ログインした状態からログアウトできる場合' do
    #ログインする
    visit root_path
    visit new_user_session_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password  
    find('input[name = "commit"]').click
    expect(current_path).to eq root_path
    #"ログアウト"のボタンが存在する
    expect(page).to have_content("ログアウト")
    #"ログアウト"のボタンを押す
    find(".user_logout").click
    #"ログアウト"のボタンが消え"新規登録"と"ログイン"のボタンがある
    expect(page).to have_no_content("ログアウト")
    expect(page).to have_content("新規登録")
    expect(page).to have_content("ログイン")
  end
end
