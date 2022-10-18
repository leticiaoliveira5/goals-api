class Api::V1::MilestonesController < Api::V1::ApiController
  before_action :authenticate_user!

  def show
    @milestone = Milestone.find(params[:id])
    render json: { milestone: @milestone,
                   steps: @milestone.steps,
                   goal: @milestone.goal }
  end

  def create
    @milestone = Milestone.new(milestone_params)
    @milestone.goal = Goal.find(params[:goal_id])
    if @milestone.save
      render json: @milestone, status: :created
    else
      render json: { msg: 'Unauthorized', errors: @milestone.errors.messages }, status: :unauthorized
    end
  end

  def destroy
    @milestone = Milestone.find(params[:id])
    @milestone.destroy
    render json: { msg: 'Record deleted' }, status: :ok
  end

  def update
    @milestone = Milestone.find(params[:id])
    @milestone.update(milestone_params)
    if @milestone.save
      render json: @milestone, status: :ok
    else
      render json: { errors: @milestone.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def milestone_params
    params.permit(:title, :description)
  end
end
