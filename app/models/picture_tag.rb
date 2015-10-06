class PictureTag < ActiveRecord::Base
  belongs_to :picture
  belongs_to :tag

  validates :picture_id, uniqueness: { scope: [:tag_id] }
end
