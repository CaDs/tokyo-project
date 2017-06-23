# frozen_string_literal: true

class Area < ActiveRecord::Base
  belongs_to :ward
  has_many :visions

  before_save :update_url_title

  def clear_cache
    TokyoProject::App.cache.delete('root_path')
    TokyoProject::App.cache.delete('areas')
    TokyoProject::App.cache.delete("area_show_#{id}")
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
