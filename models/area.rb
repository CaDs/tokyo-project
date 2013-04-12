class Area < ActiveRecord::Base
  belongs_to :ward
  has_many :visions
end
