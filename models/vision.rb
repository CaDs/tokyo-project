class Vision < ActiveRecord::Base
  belongs_to :area
  belongs_to :account
  has_many :pictures

end
