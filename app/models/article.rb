require 'carrierwave/orm/activerecord'
class Article < ActiveRecord::Base
  ACCESSIBLE_ATTRS = [:body, :region_id, :school_id, :state_id, :title,
    :season_ids, :activity_ids, :cover_photo, :cover_photo_caption, :cover_photo_cache]
  attr_accessible *ACCESSIBLE_ATTRS, as: :writer
  attr_accessible *ACCESSIBLE_ATTRS,
    :featured, :sponsored, :published_at, :user_id, as: :chief

  belongs_to :region
  belongs_to :school
  belongs_to :state
  belongs_to :user

  has_and_belongs_to_many :seasons
  has_and_belongs_to_many :activities

  mount_uploader :cover_photo, CoverPhotoUploader

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
    Article.
      joins(:activities).
      select('articles.id, articles.title, articles.published_at, articles.slug').
      where(activities: {id: activities}).
      sponsored.
      group('articles.id, articles.title, articles.published_at, articles.slug')
  end

  protected

  def set_editing_user_as_author
    if editing_user
      self.user ||= editing_user
    end
  end
end
