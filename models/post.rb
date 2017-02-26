class Post < ActiveRecord::Base
  def clear_cache
    # should clear cache for itself, and the index
    keys = ["blog_show_#{id}", 'blog']
    keys.each { |k| TokyoProject.cache.delete(k) }
  end
end
