class RootController < ApplicationController
  skip_before_action :authenticate_access_token

  def status
  end
end
