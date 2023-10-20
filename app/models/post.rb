# this is the model for post
class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :picture
  has_many :comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length:{
    minimum: 5

  }
end
