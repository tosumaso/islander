require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
    @post.images = fixture_file_upload("/files/test_image.jpg")
  end
  describe 'ポスト投稿機能' do
    context '投稿できる場合' do
      it 'content,またはimagesが存在する場合' do
        expect(@post).to be_valid
      end
      it 'evaluation_idが１以外で選択された場合' do
        expect(@post).to be_valid
      end
    end
    context '投稿できない場合' do
      it 'contentまたはimagesがない場合' do
        @post.content = ""
        @post.images = nil
        @post.valid?
        expect(@post.errors.full_messages).to include("本文が入力されていません。")
      end
      it 'evaluation_idの1が選択された場合' do
        @post.evaluation_id = 1
        @post.valid?
        expect(@post.errors.full_messages).to include("評価を入力してください。")
      end
    end
  end
end
