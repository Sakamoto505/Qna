class AnswerMailer < ApplicationMailer

  def notify_question_author(answer)
    @answer = answer
    @question = answer.question

    mail(to: 'example@example.com', subject: 'You have new answer on your question')
  end
end