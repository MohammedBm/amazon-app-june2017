class Product < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  belongs_to :category
  belongs_to :user

  has_many :reviews, dependent: :destroy
  validates(:title, { presence: { message: 'must be provided' },
                      uniqueness: true
                        });


  validates(:description, { presence: true, length: { minimum: 10, maximum: 680 }})
  validates(:price, numericality: {greater_than: 0})

# description



  after_initialize :set_defaults
  before_validation :titleize_title



  def self.search(title)
    # Product.where('title ILIKE ?', "%#{title}%" ).order(:title, :description) +Product.where('description ILIKE ?', "%#{title}%" ).order(:title, :description)
    # title = word.downcase
    one = self.where('title ILIKE ?', "%#{title}%" ).order(:title, :description)
    two = self.where('description ILIKE ?', "%#{title}%" ).order(:title, :description)
    one + two;
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

def tag_list=(value)
  self.tags = value.split(/\s*,\s*/).map do |name|
    Tag.where(name: name.downcase).first_or_create!
  end
end





private

  def set_defaults
    self.price ||= 1
  end

  def titleize_title
    self.title = title.titleize if title.present?
  end

end
