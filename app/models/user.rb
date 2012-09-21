class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  ACCESSIBLE_ATTRS = [:email, :password, :password_confirmation, :remember_me, :name]
  attr_accessible *ACCESSIBLE_ATTRS
  attr_accessible *ACCESSIBLE_ATTRS, :role, as: :chief
  # attr_accessible :title, :body

  ROLES = ["user", "chief", "writer"]

  validates_inclusion_of :role, in: ROLES
  validates_presence_of :name

  ROLES.each do |r|
    send(:define_method, "#{r}?") do
      self.role == "#{r}"
    end
  end

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

  protected

  def send_invitation
    invite!
  end

  def password_required?
    invitation_accepted_at.present? && super
  end

end
