class Api::GoalsController < Api::ApiController
  def index
    render json: { msg: 'Hello World' }, status: :ok
  end

  def new; end

  def show; end
end
