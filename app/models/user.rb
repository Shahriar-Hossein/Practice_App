class User < ApplicationRecord
  # Use the 'attr_accessor' macro only if you need a virtual attribute, but in this case, it's not required.
  # attr_accessor :login

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, authentication_keys: [:login]

  # Define the 'login' method to return the appropriate value for authentication.
  def login
    @login || username || email
  end

  # Use the 'find_for_database_authentication' method to customize how users are authenticated.
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)

    where(conditions)
      .where("lower(username) = :value OR lower(email) = :value", value: login.strip.downcase)
      .first
  end

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
  validate :image_type
  # all user defined validations are here
  private
  def minimum_7_years_old
    return if date_of_birth.blank?

    if date_of_birth + 7.years > Date.today
      errors.add(:date_of_birth, "ERROR. USER must be atleast 7 years old")
    end
  end

  def image_type
    if image.attached? && !image.content_type.in?(%('image/jpeg image/jpg image/png'))
      errors.add(:image, 'needs to be jpg, jpeg or png')
    elsif !image.attached?
      errors.add(:image, 'must be added')
    end
  end

end
