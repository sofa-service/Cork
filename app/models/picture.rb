class Picture < ActiveRecord::Base
  has_many :picture_tags
  has_many :tags, through: :picture_tags

  validates :url, uniqueness: true
  validates :url, format: { with: /\.(jpg|jpeg|png|gif)\z/i }

  attr :tag_name
end
