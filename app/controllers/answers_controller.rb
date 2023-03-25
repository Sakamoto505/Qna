# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :find_question, only: %i[new create]
  before_action :answer, only: %i[update destroy set_best]

  def index
    @answers = @question.answers
  end

  def new
    @answer = @question.answers.new
  end

  def destroy
    @answer.destroy if current_user.is_owner?(@answer.author)
  end

  def create
    @answer = @question.answers.new(answer_params)
    @answer.author = current_user
    @answer.save

    respond_to do |format|
      if @answer.save
        format.json { render json: @answer }
      else
        format.json do
          render json: @answer.errors.full_messages, status: :unprocessable_entity
        end
      end
    end
  end

  def set_best
    # здесь должен быть автор вопроса, а не автор ответа
    @answer.mark_as_best if current_user.is_owner?(@answer.question.author)
    @question = @answer.question
    @question.save
  end

  def update
    return unless current_user.is_owner?(@answer.author)

    @answer.links.destroy_all
    @answer.update(answer_params)
    @question = @answer.question
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer
    @answer = Answer.with_attached_files.find_by(id: params[:id])
  end

  def answer_params
    (params[:answer] || ActionController::Parameters.new).permit(:body, files: [],
                                                                        links_attributes: %i[name url])
  end
end
