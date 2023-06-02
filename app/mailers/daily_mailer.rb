class DailyMailer < ApplicationMailer
  def digest(_user)
    @questions = Question.where(created_at: 1.day.ago..Time.now)
    mail(to: 'example@example.com', subject: 'Daily Digest')
  end
end
