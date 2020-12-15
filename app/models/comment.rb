class Comment < ApplicationRecord
  belongs_to :map
  belongs_to :user

  validates :content, presence: true, length: {maximum: 100, message: 'は200文字以内のみ可'}
end
