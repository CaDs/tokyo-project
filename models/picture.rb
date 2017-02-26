# frozen_string_literal: true
class Picture < ActiveRecord::Base
  belongs_to :vision
  validates_uniqueness_of :flickr_id

  scope :published, -> { where(is_published: true) }

  def flickr_version
    FlickrConnector.new.get_picture(flickr_id)
  end

  def thumb
    FlickRaw.url_t(flickr_version)
  end

  def medium
    FlickRaw.url_z(flickr_version)
  end

  def large
    FlickRaw.url_b(flickr_version)
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
end
