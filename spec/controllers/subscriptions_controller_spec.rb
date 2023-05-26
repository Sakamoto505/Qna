require 'rails_helper'


RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question) }

  describe "POST #create" do
    context "when user is authenticated" do
      before { sign_in user }

      it "creates a new subscription" do
        expect {
          post :create, params: { question_id: question.id }
        }.to change(Subscription, :count).by(1)
      end

      it "redirects to the question page with a success notice" do
        post :create, params: { question_id: question.id }
        expect(response).to redirect_to(question)
        expect(flash[:notice]).to eq("Successfully subscribed to question updates.")
      end
    end

    context "when user is not authenticated" do
      it "redirects to the sign-in page" do
        post :create, params: { question_id: question.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:subscription) { create(:subscription, user: user, question: question) }

    context "when user is authenticated" do
      before { sign_in user }

      it "destroys the subscription" do
        expect {
          delete :destroy, params: { id: subscription.id }
        }.to change(Subscription, :count).by(-1)
      end

      it "redirects to the question page with a success notice" do
        delete :destroy, params: { id: subscription.id }
        expect(response).to redirect_to(question)
        expect(flash[:notice]).to eq("Successfully unsubscribed from question updates.")
      end
    end

    context "when user is not authenticated" do
      it "redirects to the sign-in page" do
        delete :destroy, params: { id: subscription.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
