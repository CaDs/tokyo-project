class Post < ActiveRecord::Base
  belongs_to :account

  def clear_cache
    #should clear cache for itself, and the index
    keys = ["blog_show_#{self.id}", "blog"]
    keys.each{|k| TokyoProject.cache.delete(k)}
  end

end
