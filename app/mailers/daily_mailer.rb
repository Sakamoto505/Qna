class DailyMailer < ApplicationMailer

  def digest(user)
    @questions = Question.where(created_at: 1.day.ago..Time.now)
    mail(to: user.email, subject: 'Daily Digest')
  end
end