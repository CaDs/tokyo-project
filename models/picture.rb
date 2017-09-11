# frozen_string_literal: true

class Picture < ActiveRecord::Base
  belongs_to :vision
  validates_uniqueness_of :flickr_id

  scope :published, -> { where(is_published: true) }

  def flickr_version
    FlickrConnector.new.get_picture(flickr_id)
  end

  def thumb
    return thumb_size_url if thumb_size_url.present?
    cache_key = "cached_picture_#{id}_tumb"
    Padrino.cache.fetch(cache_key) do
      url = FlickRaw.url_t(flickr_version)
      update_attribute(:thumb_size_url, url)
      Padrino.cache.store(cache_key, url, expires: 86_400)
    end
  end

  def medium
    return medium_size_url if medium_size_url.present?
    cache_key = "cached_picture_#{id}_medium"
    Padrino.cache.fetch(cache_key) do
      url = FlickRaw.url_z(flickr_version)
      update_attribute(:medium_size_url, url)
      Padrino.cache.store(cache_key, url, expires: 86_400)
    end
  end

  def large
    return large_size_url if large_size_url.present?
    cache_key = "cached_picture_#{id}_large"
    Padrino.cache.fetch(cache_key) do
      url = FlickRaw.url_b(flickr_version)
      update_attribute(:large_size_url, url)
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

    %w[_tumb _medium _large].each do |suffix|
      TokyoProject::App.cache.delete(key + suffix)
    end

    keys = [
      "vision_show_#{vision.id}",
      "vision_show_#{vision.url_title}",
      "vision_show_#{vision.id}_#{id}",
      "vision_show_#{vision.url_title}_#{id}",
      "places_show_#{vision.id}",
      "places_show_#{vision.url_title}",
      "places_show_#{vision.id}_#{id}",
      "places_show_#{vision.url_title}_#{id}"
    ]
    keys.each { |k| TokyoProject::App.cache.delete(k) }
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
