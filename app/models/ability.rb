# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize user
    can :read, :all
    return unless user

    can :create, Request
    can :update, Request, status: :fresh, user_id: user.id
    can :manage, :all if user.is_admin
  end
end
