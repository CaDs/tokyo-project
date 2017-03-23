# frozen_string_literal: true
class Picture < ActiveRecord::Base
  belongs_to :vision
  validates_uniqueness_of :flickr_id

  scope :published, -> { where(is_published: true) }

  def flickr_version
    FlickrConnector.new.get_picture(flickr_id)
  end

  def thumb
    cache_key = "cached_picture_#{id}_tumb"
    Padrino.cache.fetch(cache_key) do
      url = FlickRaw.url_t(flickr_version)
      Padrino.cache.store(cache_key, url, expires: 86_400)
    end
  end

  def medium
    cache_key = "cached_picture_#{id}_medium"
    Padrino.cache.fetch(cache_key) do
      url = FlickRaw.url_z(flickr_version)
      Padrino.cache.store(cache_key, url, expires: 86_400)
    end
  end

  def large
    cache_key = "cached_picture_#{id}_large"
    Padrino.cache.fetch(cache_key) do
      url = FlickRaw.url_b(flickr_version)
      Padrino.cache.store(cache_key, url, expires: 86_400)
    end
  end

  def pinpoint_code(label = '1')
    code = nil
    if latitude && longitude
      code = "&markers=|color:blue|label:#{label}|#{latitude},#{longitude}"
    else
      code ''
    end
    code
  end

  def clear_cache
    # should clear cache for itself, the vision and the area
    key = "cached_picture_#{id}"

    %w(_tumb _medium _large).each do |suffix|
      Padrino.cache.delete(key + suffix)
    end

    keys = ["vision_show_#{vision.id}", "vision_show_#{vision.id}_#{id}"]
    keys.each { |k| Padrino.cache.delete(k) }
    vision.clear_cache
  end

  def seconds_to_publish
    schedule_at.to_i - Time.now.to_i
  rescue
    0
  end

  def self.preload_all_pictures
    Picture.find_each do |picture|
      puts picture.thumb
      puts picture.medium
      puts picture.large
    end
  end
end
