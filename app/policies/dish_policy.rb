class DishPolicy < ApplicationPolicy
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
    token.super_level?
  end

  def create?
    token.super_level?
  end

  def update?
    token.super_level?
  end

  def destroy?
    token.super_level?
  end
end
