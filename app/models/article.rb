require 'carrierwave/orm/activerecord'
class Article < ActiveRecord::Base
  ACCESSIBLE_ATTRS = [:body, :region_id, :school_id, :state_id, :title, :geolocation,
    :season_ids, :activity_ids, :cover_photo, :cover_photo_caption, :cover_photo_cache]
  attr_accessible *ACCESSIBLE_ATTRS, as: :writer
  attr_accessible *ACCESSIBLE_ATTRS,
    :featured, :sponsored, :published_at, :user_id, as: :chief

  belongs_to :region
  belongs_to :school
  belongs_to :state
  belongs_to :user,
    counter_cache: true

  has_and_belongs_to_many :seasons
  has_and_belongs_to_many :activities

  mount_uploader :cover_photo, CoverPhotoUploader

  include Gmaps4rails::ActsAsGmappable
  acts_as_gmappable :check_process => false, :address => "geolocation"

  attr_accessor :editing_user

  validates_presence_of :school_id, :user_id, :body, :title, :seasons,
    :activities, :cover_photo, :cover_photo_caption
  validates_inclusion_of :featured, :sponsored, in: [true, false]

  before_validation :set_editing_user_as_author, on: :create

  scope :published, where(arel_table[:published_at].not_eq(nil)).
    order(:published_at).reverse_order

  scope :not_featured, where(arel_table[:featured].eq(false))
  scope :not_sponsored, where(arel_table[:sponsored].eq(false))

  scope :published_no_flags, published.not_featured.not_sponsored
  scope :sponsored, where(arel_table[:sponsored].eq(true)).published
  scope :featured, where(arel_table[:featured].eq(true)).published

  extend FriendlyId
  friendly_id :title, use: :slugged

  def activity_sponsors
    self.class.activity_sponsors(activities)
  end

  def text_preview(chars = 950)
    Sanitize.clean(body.truncate(chars), Sanitize::Config::RESTRICTED)
  end

  class << self

    def activity_sponsors(activities)
      by_activities(activities).sponsored
    end

    def recent_by_user(user)
      published.where(user_id: user)
    end

    def recent_by_school(school)
      published.where(school_id: school)
    end

    def recent_by_activities(activities)
      published.by_activities(activities)
    end
  end

  protected

  class << self
    def by_activities(activities)
      select_cols = "articles.id, articles.title, articles.published_at,
        articles.slug, articles.cover_photo, articles.cover_photo_caption"
      joins(:activities).
      select(select_cols).
      where(activities: {id: activities}).
      group(select_cols)
    end
  end

  def set_editing_user_as_author
    if editing_user
      self.user ||= editing_user
    end
  end
end
