class WantedItem < ActiveRecord::Base
  attr_accessible :description, :school_id, as: :chief
  belongs_to :school
end
