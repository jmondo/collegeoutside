class State < ActiveRecord::Base
  attr_accessible nil
  validates_presence_of :abbreviation, :name
end
