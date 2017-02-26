class Area < ActiveRecord::Base
  belongs_to :ward
  has_many :visions

  before_save :update_url_title

  def clear_cache
    TokyoProject.cache.delete('root_path')
    TokyoProject.cache.delete('areas')
    TokyoProject.cache.delete("area_show_#{id}")
  end

  def update_url_title
    tmp_title = begin
                  name.delete(',')
                      .delete('.')
                      .split(' ')
                      .collect(&:capitalize)
                      .join('')
                      .underscore
                rescue
                  nil
                end
    self.url_title = URI.encode(tmp_title)
  end
end
