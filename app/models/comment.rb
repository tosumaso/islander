class Comment < ApplicationRecord
  belongs_to :map
  belongs_to :user

  validates :content, presence: true, length: {maximum: 40, message: 'は40文字以内のみ可'}
end
