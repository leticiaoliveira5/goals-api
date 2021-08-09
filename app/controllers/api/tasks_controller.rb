class Api::TasksController < Api::ApiController 
  def index
    render json: {}, status: 200
  end
end