class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # association with other classes
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :image
  # validation for user information
  # validating name , it can not
  # contain any special characters
  validates :name,
            presence: true,
            format:
            {
              with: /\A[a-zA-Z]+\z/,
              message: 'only characters are allowed'
            }
  validates :lastName, presence: true,
            format:
            {
              with: /\A[a-zA-Z]+\z/,
              message: 'only characters are allowed'
            }
  # validating contact number
  # length must be 11 and only numbers allowed
  validates :contact_number,
            presence: true,
            length:
            {
              is: 11
            },
            format:
            {
              with: /\A[0-9]+\z/,
              message: 'only numbers are allowed'
            }
  validates :gender, presence: true

  validates :image, attached: true

  # validates :date_of_birth, attached: true
  validate :minimum_7_years_old

  def minimum_7_years_old
    return if date_of_birth.blank?

    if date_of_birth + 7.years > Date.today
      errors.add(:date_of_birth, "ERROR. USER must be atleast 7 years old")
    end
  end

end
