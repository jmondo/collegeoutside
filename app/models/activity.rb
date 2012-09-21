class Activity < ActiveRecord::Base
  attr_accessible nil
  validates_presence_of :name
  has_and_belongs_to_many :articles

  scope :except_other, where(arel_table[:name].not_eq('other'))

  extend FriendlyId
  friendly_id :name, use: :slugged
end
