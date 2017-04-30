class ApplicationController < ActionController::API
  # Include for OAuth authentication
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  # Include for authorization
  include Pundit

  attr_reader :current_app, :current_user, :current_token

  before_action :authenticate_access_token

  rescue_from(Pundit::NotAuthorizedError) { head :unauthorized }
  rescue_from(ActiveRecord::DeleteRestrictionError) { head :precondition_required }

  # Use custom context instead of current_user
  def pundit_user
    [current_app, current_user, current_token, {
      where: params[:where],
      order: params[:order],
      limit: params[:limit],
      offset: params[:offset]
    }]
  end

  private

  # Authenticate access_token in the request
  def authenticate_access_token
    token = Token.find_by(
      uuid: headers['Authorization'] || params[:access_token],
      kind: 'access'
    )

    if token && !token.expired?
      @current_app = token.app
      @current_user = token.user
      @current_token = token

      token.update_columns(last_used_at: Time.now, last_used_ip: request.remote_ip)
    else
      head :unauthorized
    end
  end
end
