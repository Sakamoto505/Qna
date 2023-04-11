# frozen_string_literal: true

class AnswersChannel < ApplicationCable::Channel
  def follow
    stream_from "answer_#{params[:question_id]}"
  end
end
