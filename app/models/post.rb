class Post < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :map
  belongs_to :evaluation
  belongs_to :user
  has_many_attached :images

  validates :content, presence: true, unless: :image_attached?
  validates :evaluation_id, presence: true, numericality: {other_than: 1}

  def image_attached?
    self.images.attached?
  end

end
