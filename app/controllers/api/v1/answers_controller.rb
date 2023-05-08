class Api::V1::AnswersController < Api::V1::BaseController
  def index
    answers = Answer.where(question_id: params[:question_id])
    render json: answers, each_serializer: AnswerSerializer
  end
end