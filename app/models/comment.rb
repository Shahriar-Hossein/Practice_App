# class for comments
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  #validates :commenter, presence: true
  validates :body, presence: true, length: {
    minimum: 5
  }

end
