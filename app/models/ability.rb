class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.chief?
      can :manage, :all
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard
    elsif user.writer?
      can :manage, Article, {user_id: user.id, published_at: nil}
    end
  end

end
