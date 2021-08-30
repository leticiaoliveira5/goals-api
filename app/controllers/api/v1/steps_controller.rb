class Api::V1::StepsController < Api::V1::ApiController
  before_action :authenticate_user!

  def show
    @step = Step.find(params[:id])
    render json: @step, status: :ok
  end

  def new
    @step = Step.new(
      title: [:title],
      description: [:description]
    )
  end

  def create
    @step = Step.new(step_params)
    @step.milestone = Milestone.find(params[:milestone_id])
    if @step.save
      render json: @step, status: :created
    else
      render json: { msg: 'Unauthorized', errors: @step.errors.messages }, status: :unauthorized
    end
  end

  def destroy
    @step = Step.find(params[:id])
    @step.destroy
    render json: { msg: 'Record deleted' }, status: :ok
  end

  def edit
    @step = Step.find(params[:id])
  end

  def update
    @step = Step.find(params[:id])
    @step.update(step_params)
    if @step.save
      render json: @step, status: :ok
    else
      render json: { errors: @step.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def step_params
    params.permit(:title, :description)
  end
end
