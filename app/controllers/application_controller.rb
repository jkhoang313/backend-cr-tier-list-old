class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception
  attr_reader :current_user

  def current_user
    token = request.headers['Auth-Token']
    if token
      user_info = Auth.decode(token)
      User.find(user_info['user_id'])
    end
  end
end
