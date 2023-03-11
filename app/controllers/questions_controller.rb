# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :question, except: [:index]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
    @question.links.new
  end

  def create
    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      render :new
    end
  end

  def show
    @answer = Answer.new
    @answer.links.new
    @answers = @question.answers
    @best_answer = @question.best_answer
    @other_answers = @question.answers.where.not(id: @question.best_answer_id)
  end

  def update
    @question.update(question_params) if current_user.is_owner?(@question.author)
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
    @question = params[:id] ? Question.with_attached_files.find(params[:id]) : current_user.questions.new(question_params)
  end

  def question_params
    (params[:question] || ActionController::Parameters.new).permit(:title, :body, files: [],
                                                                   links_attributes: [:id, :name, :url, :_destroy])
  end
end
