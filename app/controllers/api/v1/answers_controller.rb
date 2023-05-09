class Api::V1::AnswersController < Api::V1::BaseController

  before_action :find_answer, only: %i[show update destroy]

  def show
    render json: @answer, serializer: AnswerSerializer
  end

  def index
    answers = Answer.where(question_id: params[:question_id])
    render json: answers, each_serializer: AnswerSerializer
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end
end