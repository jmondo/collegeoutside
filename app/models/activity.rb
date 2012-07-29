class Activity < ActiveRecord::Base
  attr_accessible nil
  validates_presence_of :name
  has_and_belongs_to_many :articles
end
