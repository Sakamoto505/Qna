require "rails_helper"


RSpec.describe AnswerMailer, type: :mailer do
  let(:answer) { create(:answer) }

  describe "notify_question_author" do
    let(:mail) { AnswerMailer.notify_question_author(answer) }

    it "renders the headers" do
      expect(mail.subject).to eq("You have new answer on your question")
      expect(mail.to).to eq(["example@example.com"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("You have received a new answer on your question:")
      expect(mail.body.encoded).to match(answer.body)
      expect(mail.body.encoded).to match(answer.question.title)
    end
  end
end
