class Ability
  include CanCan::Ability




  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    end


    can :manage, Product do |prod|
      prod.user == user
    end

    can :destroy, Review do |rev|
      rev.user == user || rev.product.user == user
    end



    can :like, Review do |ques|
      ques.user != user
    end

    cannot :like, Review do |ques|
      ques.user == user
    end



  end
end
