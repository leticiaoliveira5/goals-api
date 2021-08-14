class Api::GoalsController < Api::ApiController
  def index
    render json: { msg: 'Hello World' }, status: :ok
  end

  def new(response)
    @goal = Goal.new(
      title: response[:title],
      description: resnponse[:description],
      deadline: response[:deadline]
    )
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      render json: { goal: @goal.as_json }, status: :created
    else
      render json: { msg: 'Unauthorized', errors: @goal.errors.messages }, status: :unauthorized
    end
  end

  private

  def goal_params
    params.permit(:title, :description, :deadline)
  end
end
