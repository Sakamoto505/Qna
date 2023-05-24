require "rails_helper"

RSpec.describe DailyMailer, type: :mailer do
  describe "digest" do
    let(:user) { create(:user) }
    let!(:questions) { create_list(:question, 3) }
    let(:mail) { DailyMailer.digest(user) }

    it "sends the email to the correct recipient" do
      expect(mail.to).to eq(['example@example.com'])
    end

    it "has the correct subject" do
      expect(mail.subject).to eq("Daily Digest")
    end

    it "includes the created questions in the email body" do
      questions.each do |question|
        expect(mail.body.encoded).to include(question.title)
      end
    end

    it "includes the correct content in the email body" do
      expect(mail.body.encoded).to include("Daily Digest")
    end
  end
end
