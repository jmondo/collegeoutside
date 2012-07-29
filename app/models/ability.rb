class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.chief?
      can :manage, :all
      can :access, :rails_admin   # grant access to rails_admin
      can :show, :writer_dashboard
      can :dashboard
    elsif user.writer?
      can :show, :writer_dashboard
      can :manage, Article, {user_id: user.id, published_at: nil}
    end
  end

end
