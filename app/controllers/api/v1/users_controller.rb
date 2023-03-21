module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :authenticate_user!

      def show
        @user = User.find(params[:id])
        render json: { user: @user }
      end
    end
  end
end
