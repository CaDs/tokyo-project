class Vision < ActiveRecord::Base
  belongs_to :area
  has_many :pictures

end
