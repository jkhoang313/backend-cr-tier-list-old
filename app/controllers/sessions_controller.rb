class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email].downcase)

    if user && user.authenticate(params[:password])
      jwt = Auth.encrypt({user_id: user.id})
      render json: {jwt: jwt, user: UserSerializer.new(user)}, root: nil
    else
      render json: {error: "Incorrect email or password"}, status: 400
    end
  end
end
