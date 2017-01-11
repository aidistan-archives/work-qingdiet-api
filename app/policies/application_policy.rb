class ApplicationPolicy
  attr_reader :app, :user, :token, :record

  def initialize(token, record)
    @app = token.app
    @user = token.user
    @token = token
    @record = record
  end

  def scope
    Pundit.policy_scope!(token, record.class)
  end

  class Scope
    attr_reader :app, :user, :token, :scope

    def initialize(token, scope)
      @app = token.app
      @user = token.user
      @token = token
      @scope = scope
    end

    def resolve
      scope
    end
  end
end
