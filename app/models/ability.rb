class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.chief?
      can :manage, :all
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard
    elsif user.writer?
    end
  end

end
