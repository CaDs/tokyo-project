class Area < ActiveRecord::Base
  belongs_to :ward
  has_many :visions
  validates :name, uniqueness: true

  def clear_cache
    TokyoProject.cache.delete("root_path")
    TokyoProject.cache.delete("areas")
    TokyoProject.cache.delete("area_show_#{self.id}")
  end
end
