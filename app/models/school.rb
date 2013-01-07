class School < ActiveRecord::Base
  attr_accessible :name, :full_name, :location, :contact_html, as: :chief
  validates_presence_of :name
  has_many :articles
  has_many :users
  has_many :wanted_items

  extend FriendlyId
  friendly_id :name, use: :slugged
end
