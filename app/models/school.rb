class School < ActiveRecord::Base
  attr_accessible :name, :full_name, :location, :contact_html, as: :chief
  validates_presence_of :name, :full_name, :location
  has_many :articles
  has_many :users

  extend FriendlyId
  friendly_id :name, use: :slugged
end
