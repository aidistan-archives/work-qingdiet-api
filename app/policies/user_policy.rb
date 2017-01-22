class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope = super

      if token.super_level?
        scope
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  def show?
    token.super_level? || record == user
  end

  def update?
    token.super_level? || record == user
  end
end
