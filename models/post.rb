# frozen_string_literal: true
class Post < ActiveRecord::Base
  def clear_cache
    # should clear cache for itself, and the index
    keys = ["blog_show_#{id}", 'blog']
    keys.each { |k| TokyoProject::App.cache.delete(k) }
  end
end
