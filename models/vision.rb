# frozen_string_literal: true

require 'open-uri'

class Vision < ActiveRecord::Base
  belongs_to :area
  belongs_to :account
  has_many :pictures

  DEFAULT_MEDIUM_PICTURE_URL =
    'http://farm9.staticflickr.com/8300/7814117342_b345e98c65_m.jpg'

  before_save :update_url_title

  def published_pictures
    pictures.published.order('created_at DESC')
  end

  def map_info?
    pictures.where('latitude != ? && longitude != ?', '', '').any?
  end

  def map_data
    res = {}
    geolocations = pictures.find_all { |p| p.is_published == true }.collect { |p| [p.latitude, p.longitude].compact }.delete_if(&:empty?)
    center = Geocoder::Calculations.geographic_center(geolocations)
    static_url = "http://maps.googleapis.com/maps/api/staticmap?center=#{center}&zoom=16&size=650x350&maptype=roadmap&sensor=false"
    dynamic_url = "http://maps.google.com/maps?q=#{center.first},#{center.last}&zoom=16&size=650x350&maptype=roadmap&sensor=false"
    legend = []
    index = 1
    pictures.find_all { |p| p.is_published == true && p.latitude.to_s != '' }.each do |picture|
      pinpoint = picture.pinpoint_code(index)
      next unless pinpoint != ''
      legend <<  [index, picture.id]
      static_url += pinpoint
      dynamic_url += pinpoint
      index += 1
    end
    res['static_url'] = static_url
    res['dynamic_url'] = dynamic_url
    res['legend'] = legend
    res
  end

  def clear_cache
    TokyoProject::App.cache.delete('visions')
    TokyoProject::App.cache.delete('places')
    TokyoProject::App.cache.delete("vision_show_#{id}")
    TokyoProject::App.cache.delete("vision_show_#{url_title}")
    TokyoProject::App.cache.delete("places_show_#{id}")
    TokyoProject::App.cache.delete("places_show_#{url_title}")
    TokyoProject::App.cache.delete("maps_show_#{id}")
    area.clear_cache
  end

  def update_url_title
    tmp_title = begin
                  title.delete(',')
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
