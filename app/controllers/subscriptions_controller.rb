class SubscriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_question, only: [:create]

  def create
    @subscription = current_user.subscriptions.new(question: @question)
    authorize @subscription

    if @subscription.save
      redirect_to @question, notice: 'Successfully subscribed to question updates.'
    else
      redirect_to @question, alert: 'Failed to subscribe to question updates.'
    end
  end

  def destroy
    @subscription = Subscription.find(params[:id])
    authorize @subscription

    if @subscription.destroy
      redirect_to @subscription.question, notice: 'Successfully unsubscribed from question updates.'
    else
      redirect_to @subscription.question, alert: 'Failed to unsubscribe from question updates.'
    end
  end

  private

  def find_question
    @question = Question.find(params[:question_id])
  end
end
