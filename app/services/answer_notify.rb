class AnswerNotify

  def send_notify(answer)
    answer.question.subscriptions.map(&:user).each do |user|
      AnswerMailer.notify_question_author(answer, user).deliver_later
    end
  end
end
