class Api::GoalsController < Api::ApiController 
  def index
    render json: {}, status: 200
  end

  def new; end
  def show; end
end