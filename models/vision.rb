class Vision < ActiveRecord::Base
  belongs_to :area
  belongs_to :account
  has_many :pictures

  DEFAULT_MEDIUM_PICTURE_URL = "http://farm9.staticflickr.com/8300/7814117342_b345e98c65_m.jpg"

  def published_pictures
    pictures.order("created_at DESC").find_all{|p| p.is_published }
  end

  def clear_cache
    TokyoProject.cache.delete("visions")
    TokyoProject.cache.delete("vision_show_#{self.id}")
    area.clear_cache
  end

end
