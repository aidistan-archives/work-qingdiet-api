class V1::LoginController < ApplicationController
  skip_before_action :authenticate_access_token
end
