class RootController < ApplicationController
  skip_before_action :authenticate_access_token

  def status
    render layout: 'layouts/application'
  end
end
