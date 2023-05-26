class AnswerMailer < ApplicationMailer

  def notify_question_author(answer)
  # def notify_question_author(answer, user)
    @answer = answer
    @question = answer.question

  mail(to: 'example@example.com', subject: 'You have new answer on your question')
    # mail(to:  user.email, subject: 'You have new answer on your question')
  end
end