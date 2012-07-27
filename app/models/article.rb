class Article < ActiveRecord::Base
  ACCESSIBLE_ATTRS = [:body, :region_id, :school_id, :state_id, :title]
  attr_accessible *ACCESSIBLE_ATTRS
  attr_accessible *ACCESSIBLE_ATTRS,
    :featured, :sponsored, :published_at, :user_id, as: :chief

  belongs_to :region
  belongs_to :school
  belongs_to :state
  belongs_to :user

  attr_accessor :editing_user

  validates_presence_of :school_id, :user_id, :body, :title
  validates_inclusion_of :featured, :sponsored, in: [true, false]

  before_validation :set_editing_user_as_author, on: :create

  protected

  def set_editing_user_as_author
    if editing_user
      self.user ||= editing_user
    end
  end
end
