class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :find_question, only: %i[new create]
  before_action :answer, only: %i[edit destroy]

  def index
    @answers = @question.answers
  end
  def new
    @answer = @question.answers.new
  end

  def destroy
      @answer.destroy if current_user.is_owner?(@answer.author)
      redirect_to question_path(@answer.question), notice: 'Answer was successfully deleted'
  end


  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user
    if @answer.save
      redirect_to @question
    else
      render template: 'questions/show'
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer
    @answer = Answer.find_by(id: params[:id])
  end

  def answer_params
    (params[:answer] || ActionController::Parameters.new).permit(:body)
  end
end
