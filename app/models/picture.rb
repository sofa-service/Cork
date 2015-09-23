class Picture < ActiveRecord::Base
  belongs_to :tag

  attr :tag_name
end
