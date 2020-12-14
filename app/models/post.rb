class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :map
  belongs_to :evaluation
  belongs_to :user

  validates :context, presence: true
  validates :evaluation_id, numericality: {other_than: 1}
end
