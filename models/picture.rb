class Picture < ActiveRecord::Base
  belongs_to :vision

  def flickr_version
    FlickrConnector.new.get_picture(self.flickr_id)
  end

  def thumb
    FlickRaw.url_t(flickr_version) rescue "/images/default_small.jpg"
  end

  def medium
    FlickRaw.url_m(flickr_version) rescue "/images/default_medium.jpg"
  end

  def large
    FlickRaw.url_b(flickr_version) rescue "/images/default_medium.jpg"
  end
end
