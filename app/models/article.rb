class Article < ActiveRecord::Base
  ACCESSIBLE_ATTRS = [:body, :region_id, :school_id, :state_id, :title, :season_ids, :activity_ids]
  attr_accessible *ACCESSIBLE_ATTRS, as: :writer
  attr_accessible *ACCESSIBLE_ATTRS,
    :featured, :sponsored, :published_at, :user_id, as: :chief

  belongs_to :region
  belongs_to :school
  belongs_to :state
  belongs_to :user

  has_and_belongs_to_many :seasons
  has_and_belongs_to_many :activities

  attr_accessor :editing_user

  validates_presence_of :school_id, :user_id, :body, :title, :seasons, :activities
  validates_inclusion_of :featured, :sponsored, in: [true, false]

  before_validation :set_editing_user_as_author, on: :create

  protected

  def set_editing_user_as_author
    if editing_user
      self.user ||= editing_user
    end
  end
end
