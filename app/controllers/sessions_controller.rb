class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)

    if user && user.authenticate(params[:password])
      jwt = Auth.encrypt({user_id: user.id})
      render json: {jwt: jwt, user: user}
    end
  end
end
