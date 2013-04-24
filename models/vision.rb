class Vision < ActiveRecord::Base
  belongs_to :area
  belongs_to :account
  has_many :pictures

  DEFAULT_MEDIUM_PICTURE_URL = "http://farm9.staticflickr.com/8300/7814117342_b345e98c65_n.jpg"

end
