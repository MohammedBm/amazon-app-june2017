class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :voted_answers, through: :votes, source: :answer


  has_many :likes, dependent: :destroy
  has_many :liked_review, through: :likes, source: :review

  has_secure_password

  has_many :product, dependent: :nullify
  has_many :reviews, dependent: :nullify


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX

  def full_name
    "#{first_name} #{last_name}".titleize.strip
  end
end
