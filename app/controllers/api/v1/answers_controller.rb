class Api::V1::AnswersController < Api::V1::BaseController

  before_action :find_question, only: %i[create destroy]
  before_action :find_answer, only: %i[show update destroy]

  skip_before_action :verify_authenticity_token

  def show
    render json: @answer, serializer: AnswerSerializer
  end

  def index
    answers = Answer.where(question_id: params[:question_id])
    render json: answers, each_serializer: AnswerSerializer
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_resource_owner

    if @answer.save
      render json: @answer
    else
      render json: { errors: @answer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @answer.update(answer_params)
      render json: @answer
    else
      render json: { errors: @answer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @answer

    @answer.destroy
    head :no_content
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end