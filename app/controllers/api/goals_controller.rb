class Api::GoalsController < Api::ApiController
  def index
    render json: { msg: 'Hello World' }, status: :ok
  end

  def show
    @goal = Goal.find(params[:id])
    render json: { goal: @goal.as_json,
                   milestones: @goal.milestones,
                   steps: @goal.steps }
  end

  def new
    @goal = Goal.new(
      title: [:title],
      description: [:description],
      deadline: [:deadline]
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

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    render json: { msg: 'Record deleted' }, status: :ok
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update(goal_params)
    if @goal.save
      render json: { goal: @goal.as_json }, status: :ok
    else
      render json: { msg: 'Unauthorized', errors: @goal.errors.messages }, status: :unauthorized
    end
  end

  private

  def goal_params
    params.permit(:title, :description, :deadline)
  end
end
