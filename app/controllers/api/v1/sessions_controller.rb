# app/controllers/api/v1/sessions_controller.rb
module Api
  module V1
    class SessionsController < Devise::SessionsController
      skip_before_action :verify_authenticity_token

      def create
        user = User.find_by_email(sign_in_params[:email])
        if user && user.valid_password?(sign_in_params[:password])
          render json: { token: user.generate_jwt, user: { id: user.id, email: user.email } }, status: :created
        else
          render json: { errors: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def destroy
        # Assuming you have a way to invalidate the given token
        render json: { message: 'Logged out' }, status: :ok
      end

      private

      def sign_in_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
