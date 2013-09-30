class Vision < ActiveRecord::Base
  belongs_to :area
  belongs_to :account
  has_many :pictures

  DEFAULT_MEDIUM_PICTURE_URL = "http://farm9.staticflickr.com/8300/7814117342_b345e98c65_m.jpg"

  def published_pictures
    pictures.order("created_at DESC").find_all{|p| p.is_published }
  end

  def map_data
    res = {}
    geolocations = self.pictures.find_all{|p| p.is_published == true}.collect{|p| [p.longitude, p.latitude].compact}.delete_if{|a| a.empty?}
    center = Geocoder::Calculations.geographic_center(geolocations)
    url = "http://maps.googleapis.com/maps/api/staticmap?center=#{center}&zoom=13&size=600x300&maptype=roadmap&sensor=false"
    legend = []
    index = 1
    self.pictures.find_all{|p| p.is_published == true}.each do |picture|
      pinpoint = picture.pinpoint_code(index)
      if pinpoint != ""
        legend <<  [index, picture.id]
        url += pinpoint
        index += 1
      end
    end
    res['url'] = url
    puts url
    res['legend'] = legend
    return res
  end

  def clear_cache
    TokyoProject.cache.delete("visions")
    TokyoProject.cache.delete("vision_show_#{self.id}")
    area.clear_cache
  end

end
