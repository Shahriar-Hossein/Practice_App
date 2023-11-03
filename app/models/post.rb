# this is the model for post
class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :picture
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true, length: {
    minimum: 5
  }
  validate :picture_type

  private

  def picture_type
    if picture.attached? && !picture.content_type.in?(%('image/jpeg image/jpg image/png'))
      errors.add(:picture, 'needs to be jpg, jpeg or png')
    elsif !picture.attached?
      errors.add(:picture, 'must be added')
    end

  end

end
