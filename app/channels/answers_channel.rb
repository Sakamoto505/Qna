class AnswersChannel < ApplicationCable::Channel
  # def follow
  #   stream_from "answer_#{params[:question_id]}"
  # end


  def receive(data)
    ActionCable.server.broadcast(
      "answer_#{params[:question_id]}",
      render_answer(data)
    )
  end

  private

  def render_answer(answer)
    ApplicationController.render(
      partial: 'answers/answer',
      locals: { answer: answer }
    )
  end
end