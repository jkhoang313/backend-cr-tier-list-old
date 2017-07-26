class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception
end

# require 'json_web_token'
#
# class ApplicationController < ActionController::API
#   # TODO: update all the tests to strictly use JWT auth
#   if ENV["RAILS_ENV"] != "test"
#     before_action :authenticate_request_from_token!
#   end
#   attr_reader :current_user
#
#   protected
#   # this method can be used in other controllers to check credentials:
#   def authenticate_request_from_token!
#     unless http_token && auth_token && auth_token[:account_id].to_i
#       render json: { errors: ['Not Authenticated'] }, status: :unauthorized
#       return
#     end
#
#     @current_account = Account.find(auth_token[:account_id])
#
#     rescue JWT::VerificationError, JWT::DecodeError
#       render json: { errors: ['Not Authenticated'] }, status: :unauthorized
#   end
#
#   private
#   def http_token
#     @http_token ||= if request.headers['Authorization'].present?
#       request.headers['Authorization'].split(' ').last
#     end
#   end
#
#   def auth_token
#     @auth_token ||= JsonWebToken.decode(http_token)
#   end
#
#   def jwt_payload(account)
#     return nil unless account && account.id
#     {
#       auth_token: JsonWebToken.encode({ account_id: account.id }),
#       account: { id: account.id, email: account.email }
#     }
#   end
# end
