class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.chief?
      can :manage, :all
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard
    elsif user.writer?
      can :access, :rails_admin   # grant access to rails_admin
      can :dashboard
      can :manage, Article, published_at: nil # TODO: add school_id
      can :index, School # so they can choose school from select in article/create
    end
  end

end
