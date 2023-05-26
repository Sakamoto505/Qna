require 'rails_helper'

RSpec.describe SubscriptionPolicy, type: :policy do
  let(:user) { create(:user) }
  let(:question) { create(:question) }
  let(:subscription) { create(:subscription, user: user, question: question) }
  let(:other_user) { create(:user) }
  let(:other_question) { create(:question) }

  subject { described_class }

  permissions :create? do
    it "grants access if user is not subscribed to the question" do
      expect(subject).to permit(user, Subscription.new(question: other_question))
    end

    it "denies access if user is already subscribed to the question" do
      expect(subject).not_to permit(user, subscription)
    end

    it "denies access if user is not present" do
      expect(subject).not_to permit(nil, Subscription.new(question: other_question))
    end
  end

  permissions :destroy? do
    it "grants access if user is subscribed to the question" do
      expect(subject).to permit(user, subscription)
    end

    it "denies access if user is not subscribed to the question" do
      expect(subject).not_to permit(other_user, subscription)
    end

    it "denies access if user is not present" do
      expect(subject).not_to permit(nil, subscription)
    end
  end
end
