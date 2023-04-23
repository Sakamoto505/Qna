# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  let(:other_user) { create(:user) }

  describe 'POST #create' do
    before  { login(user) }

    context 'with valid attributes' do
      it 'saves a new answer related to question in the database' do
        expect do
          post :create, params: { question_id: question.id, answer: attributes_for(:answer) },
                        format: :json
        end.to change(question.answers, :count).by(1)
      end

      context 'with invalid attributes' do
        before { login(user) }

        it 'does not save the answer' do
          expect do
            post :create,
                 params: { question_id: question, answer: attributes_for(:answer, :invalid_answer), format: :json }
          end.to_not change(question.answers, :count)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }
    let!(:answer) { create(:answer, author_id: user.id, question: question) }

    it 'deletes the answer' do
      expect { delete :destroy, params: { id: answer }, format: :js }.to change(Answer, :count).by(-1)
    end
  end

  describe 'PATCH #update' do
    before { login(user) }
    let!(:question) { create(:question, author: user) }
    let!(:answer) { create(:answer, author_id: user.id, question: question) }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { question_id: question.id, id: answer, answer: attributes_for(:answer) }, format: :js
        answer.reload
        expect(answer.body).to eq 'Answer_Body'
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        end.to_not change(answer, :body)
      end

      it 'renders update view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) }, format: :js
        expect(response).to render_template :update
      end
    end
  end
end
