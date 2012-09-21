class School < ActiveRecord::Base
  attr_accessible :name, as: :chief
  validates_presence_of :name

  extend FriendlyId
  friendly_id :name, use: :slugged
end
