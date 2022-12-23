# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :question, except: [:index]

  def index
    @questions = Question.all
  end

  def new; end

  def create
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    if current_user.is_owner?(@question.author)
      @question.destroy
      redirect_to questions_path, notice: 'Question was successfully deleted'
    else
      redirect_to questions_path, notice: 'Sorry'
    end
  end

  private

  def question
    @question = params[:id] ? Question.find(params[:id]) : current_user.questions.new(question_params)
  end

  def question_params
    (params[:question] || ActionController::Parameters.new).permit(:title, :body)
  end
end
