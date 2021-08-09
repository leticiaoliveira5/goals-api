class Api::GoalsController < Api::ApiController 
  def index
    render json: {msg: 'Hello World'}, status: 200
  end

  def new; end
  def show; end
end