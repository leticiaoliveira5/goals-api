class MembersController < ApplicationController
  before_action :authenticate_user!

  def show
    render json: { message: 'If you see this, you are in!' }
  end
end
