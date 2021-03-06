require 'carrierwave/orm/activerecord'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  ACCESSIBLE_ATTRS = [:email, :password, :password_confirmation, :remember_me, :name, :school, :photo]
  attr_accessible *ACCESSIBLE_ATTRS
  attr_accessible *ACCESSIBLE_ATTRS, :role, :position, :school_id,
    :photo, :photo_cache, :remove_photo, as: :chief
  # attr_accessible :title, :body

  ROLES = ["user", "chief", "writer"]

  validates_inclusion_of :role, in: ROLES

  # validate photo on update unless chief, do not validate on create
  # so that admin can create the user, but when they set their password they must set photo
  validates_presence_of :photo,
    on: :update,
    if: proc{ |u| u.role != "chief" }

  has_many :articles

  belongs_to :school

  has_many :activities,
    through: :articles

  ROLES.each do |r|
    send(:define_method, "#{r}?") do
      self.role == "#{r}"
    end
  end

  scope :accepted_invitation, where(arel_table[:invitation_accepted_at].not_eq(nil))

  mount_uploader :photo, ProfilePhotoUploader

  extend FriendlyId
  friendly_id :name, use: :slugged

  after_create :send_invitation

  def role_enum
    ROLES
  end

  def attr_accessible_role
    if chief?
      :chief
    else
      :default
    end
  end

  def activity_names
    activities.select('activities.name').group('activities.name')
  end

  def description
    [name, position].reject(&:blank?).join(', ')
  end

  protected

  def send_invitation
    invite!
  end

  def password_required?
    invitation_accepted_at.present? && super
  end

end
