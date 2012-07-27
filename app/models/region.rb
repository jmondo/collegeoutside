class Region < ActiveRecord::Base
  attr_accessible nil
  validates_presence_of :name
end
