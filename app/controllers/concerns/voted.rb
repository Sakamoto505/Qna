# frozen_string_literal: true

module Voted
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :set_votable, only: %i[like dislike cancel]
    before_action :check_author, only: %i[like dislike cancel]
  end

  def like
    voted(1)
  end

  def dislike
    voted(-1)
  end

  def cancel
    @votable.votes.where(user_id: current_user.id).first.destroy

    render_json
  end

  private

  def set_votable
    @votable = model_klass.find(params[:id])
  end

  def model_klass
    controller_name.classify.constantize
  end

  def check_author
    return unless current_user.is_owner?(@votable)

    render json: { error: 'You cannot vote for your own post.' }, status: :unprocessable_entity
  end

  def voted(value)
    if current_user.vote(@votable, value)
      render_json
    else
      render json: { error: 'Unable to vote.' }, status: :unprocessable_entity
    end
  end

  def render_json
    render json: { rating: @votable.rating, votable_id: @votable.id, votable_name: @votable.class.name.downcase }
  end
end
