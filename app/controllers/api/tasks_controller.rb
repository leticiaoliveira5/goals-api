class Api::TasksController < Api::ApiController
  def index
    render json: {}, status: :ok
  end
end
