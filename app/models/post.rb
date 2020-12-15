class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :map
  belongs_to :evaluation
  belongs_to :user

  validates :content, presence: true
  validates :evaluation_id, presence: true, numericality: {other_than: 1}
end
