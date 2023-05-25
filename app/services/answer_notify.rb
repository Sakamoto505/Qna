class AnswerNotify

  def send_notify(answer)
    AnswerMailer.notify_question_author(answer).deliver_later
  end
end
