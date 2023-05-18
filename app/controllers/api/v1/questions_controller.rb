class Api::V1::QuestionsController < Api::V1::BaseController

  before_action :send_question, only: %i[show update destroy]

  skip_before_action :verify_authenticity_token

  def index
    @questions = Question.all
    render json: @questions
  end

  def show
    question = Question.find(params[:id])
    render json: question, serializer: QuestionSerializer
  end

  def create
    @question = current_resource_owner.questions.new(question_params)
    authorize @question

    if @question.save
      render json: @question, status: :created
    else
      render json: { errors: @question.errors }, status: :bad_request
    end
  end

    def destroy
      authorize @question

      @question.destroy
      head :no_content
    end

  def update
    authorize @question

    if @question.update(question_params)
      render json: @question, status: :ok
    else
      render json: { errors: @question.errors }, status: :bad_request
    end
  end


  private

  def send_question
    @question = Question.find(params[:id])
  end
  def question_params
    params.require(:question).permit(:title, :body)
  end
end
