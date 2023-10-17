# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, Post
    can :read, Comment
    return unless user.present?
    can :read, User, :user_id => user.id
    # can :read, User, user_id => user.id
    # raise user_id.inspect
    # can :read, User do |u|
    #    :user_id == u.id
    # end
    can [:read, :create, :update, :destroy], Post, user: user
    can [:read, :create, :update, :destroy], Comment, user: user

    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
