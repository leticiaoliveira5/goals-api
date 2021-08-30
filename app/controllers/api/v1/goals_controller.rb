class Api::V1::GoalsController < Api::V1::ApiController
  before_action :authenticate_user!

  def index
    render json: { msg: 'Hello World' }, status: :ok
  end

  def show
    @goal = Goal.find(params[:id])
    render json: { goal: @goal,
                   milestones: @goal.milestones,
                   steps: @goal.steps }
  end

  def new
    @goal = Goal.new(
      title: [:title],
      description: [:description],
      deadline: [:deadline],
      user_id: [:user_id]
    )
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      render json: @goal, status: :created
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
      render json: @goal, status: :ok
    else
      render json: { errors: @goal.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def goal_params
    params.permit(:title, :description, :deadline, :user_id)
  end
end
