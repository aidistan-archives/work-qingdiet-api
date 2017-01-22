class AddressPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope = super

      if token.super_level?
        scope
      else
        scope.where(user: user)
      end
    end
  end

  def show?
    token.super_level? || record.user == user
  end

  def create?
    token.super_level? || record.user == user
  end

  def update?
    token.super_level? || record.user == user
  end

  def destroy?
    token.super_level? || record.user == user
  end
end
