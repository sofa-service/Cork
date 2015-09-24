class Picture < ActiveRecord::Base
  belongs_to :tag

  validates :url, uniqueness: true
  validates :url, format: { with: /\.(jpg|jpeg|png|gif)\z/i }

  attr :tag_name
end
