# README
## 概要

このアプリでは東京の離島についてログインしたユーザーが旅行記を投稿したり、他のユーザーとチャットで意見交換をすることができます。まず、実際に島に行った人がGoogle Mapに紐づく島をクリックし、その島の詳細ページ内で自身の旅行記を投稿します。他のユーザーは気になる離島のページへ進み、他の人の旅行記やコメントについてコメントを残すことができます。

## 制作背景

コロナ禍で人の少ない観光地にスポットライトが当たると考え、マイナーではあるもののそうした島々の掲示板を作成したいと考えました。また、個人的に秘境に行くのが好きで、かつ離島専門の掲示板サイトをあまり見かけないため作成に至りました。

## 本番環境

https://islander-forum.herokuapp.com/

ログイン情報(テスト用アカウント)  

・テストアカウント1  
 ・メールアドレス: samplesan@sample.com  
・パスワード: sample777

・テストアカウント2  
  ・メールアドレス: aiueo@gmail.com  
  ・パスワード: aiueo777

## DEMO

### 新規登録

https://gyazo.com/098863a1f0e9475bca21120224eb6e3a

新規登録画面です。名前、メールアドレス、パスワード(確認用含む)を入力します。

### ログイン

https://gyazo.com/8cd21eb43e511cda204fa500cdf22c8b

ログイン画面です。メールアドレス、パスワードを入力します。

### トップページ

https://gyazo.com/0cba43b52e7b9efbfd2bcd4488ddf1c1

トップページです。このGoogleマップでピン留めされている島をクリックし、その島の詳細ページへ遷移できます。

### 詳細ページ、旅行記投稿

https://gyazo.com/6242f27665cf2614f2e25648480553ec

詳細ページの旅行記投稿機能です。島の写真の下にある投稿ボタンをクリックすると投稿用のモーダル画面が表示されます。また、投稿する本文、島の評価、任意で画像を添付し詳細ページで一覧表示されます。

### 詳細ページ、コメント機能

https://gyazo.com/f0b177a966338d8c29472962f47080fd

詳細ページのコメント機能です。島の詳細ページ毎に1つコメント欄を設けており、他のユーザーの旅行記やコメントに反応することを想定しています。また、コメント機能は非同期通信で作成し、リアルタイムでのチャットを可能にしました。

## 工夫したポイント

・googlemap apiを使い、マーカーをクリックすることでマーカーに紐づいた島の詳細ページへ遷移できるようにしました。

・島の詳細ページをカテゴリで分けるのではなく、ユーザーがマップを動かして探すことでインタラクティブなサイトを実現しました。

・旅行記の投稿は他のフォーム欄よりも入力スペースが必要なため、モーダル画面を導入しました。

## 使用技術

### バックエンド

Ruby, Ruby on Rails

### フロントエンド

Html, Css, Javascript

### データベース

Mysql

### 本番環境

Heroku

### ソース管理

Github, GithubDesktop

### テスト

RSpec, Capybara

### エディタ

VSCode

## 今後実装したい機能

・deviseのユーザー管理機能をモーダル画面で実装できるようにしたいです。

・レイアウトをよりモダンにしたいと思います。

## DB設計

### User

|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|name|string|null: false|
|password|string|null: false|

### Association

has_many :posts  
has_many :comments

### Map

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association

has_many :posts  
has_many :comments

### Post

|Column|Type|Options|
|------|----|-------|
|content|text|null: false|
|evaluation_id|integer|null: false|
|user|references|null: false, foreign_key: true|
|map|references|null: false, foreign_key: true|

### Association

belongs_to :user  
belongs_to :map

### Comment

|Column|Type|Options|
|------|----|-------|
|content|string|null: false|
|user|references|null: false, foreign_key: true|
|map|references|null: false, foreign_key: true|

### Association

belongs_to :user  
belongs_to :map

## githubクローン

https://github.com/tosumaso/islander.git





