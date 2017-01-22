class ApplicationPolicy
  attr_reader :app, :user, :token, :record

  def initialize(context, record)
    @app, @user, @token = context
    @record = record
  end

  def scope
    Pundit.policy_scope!(context, record.class)
  end

  class Scope
    attr_reader :app, :user, :token, :filter, :scope

    def initialize(context, scope)
      @app, @user, @token, @filter = context
      @scope = scope
    end

    def resolve
      if filter
        scope.all
          .where(filter[:where] && filter[:where].to_unsafe_h)
          .order(filter[:order])
          .limit(filter[:limit])
          .offset(filter[:offset])
      else
        scope.all
      end
    rescue
      # Strings are forbidden in where clause
      raise Pundit::NotAuthorizedError
    end
  end
end
