# frozen_string_literal: true

class QuestionsController < ApplicationController
  include Voted
  include Commented

  before_action :authenticate_user!, except: %i[index show]
  before_action :question, except: [:index]
  before_action :find_subscription, only: %i[show update]

  after_action :publish_question, only: [:create]
  before_action :gon_variables, only: :show

  def index
    @questions = Question.all
  end

  def new
    authorize @question

    @question = Question.new
    @question.links.new
    @question.build_reward
  end

  def create
    authorize @question

    if @question.save
      redirect_to @question, notice: 'Your question successfully created.'
    else
      flash[:alert] = "Unable to save question: #{@question.errors.full_messages.join(', ')}"
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
    authorize @question
    respond_to do |format|
      format.html { redirect_to @question }
      format.js
      @question.update(question_params)
    end
  end

  def destroy
    authorize @question
    @question.destroy
    redirect_to questions_path, notice: 'Question was successfully deleted'
  end

  def search
    @questions = Question.search_by_content(params[:query])
  end

  private

  def publish_question
    return if @question.errors.any?

    ActionCable.server.broadcast(
      'questions',
      ApplicationController.render(
        partial: 'questions/question_for_channel',
        locals: { question: @question }
      )
    )
  end

  def gon_variables
    gon.question_id = @question.id
    gon.author = current_user.id if current_user
  end

  def question
    @question = params[:id] ? Question.with_attached_files.find(params[:id]) : current_user.questions.new(question_params)
  end

  def question_params
    (params[:question] || ActionController::Parameters.new).permit(:title, :body, files: [],
                                                                                  links_attributes: %i[id name url _destroy],
                                                                                  reward_attributes: %i[name image])
  end

  def find_subscription
    @subscription = @question.subscriptions.find_by(user: current_user)
  end
end
