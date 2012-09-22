class School < ActiveRecord::Base
  attr_accessible :name, :full_name, :location, as: :chief
  validates_presence_of :name, :full_name, :location
  has_many :articles

  extend FriendlyId
  friendly_id :name, use: :slugged
end
