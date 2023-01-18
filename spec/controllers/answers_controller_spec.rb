# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  let(:other_user) { create(:user) }

  describe 'GET #new' do
    before { login(user) }

    before { get :new, params: { question_id: question } }
    it 'assigns a new Answer to @answers' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    before  { login(user) }

    context 'with valid attributes' do
      it 'saves a new answer related to question in the database' do
        expect do
          post :create, params: { question_id: question.id, answer: attributes_for(:answer) },
                        format: :js
        end.to change(question.answers, :count).by(1)
      end

      it 'redirects to question view' do
        post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end

      context 'with invalid attributes' do
        before { login(user) }

        it 'does not save the answer' do
          expect do
            post :create,
                 params: { question_id: question, answer: attributes_for(:answer, :invalid_answer), format: :js }
          end.to_not change(question.answers, :count)
        end

        it 're-renders question view' do
          post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid_answer), format: :js }
          expect(response).to render_template :create
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    let!(:answer) { create(:answer, author: user, question: question) }

    it 'deletes the answer' do
      expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
    end

    it 'deletes the answer' do
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to question
    end

    it 'Attempting to delete a answer from a non-current user' do
      login(other_user)
      expect { delete :destroy, params: { id: answer } }.to_not change(Answer, :count)
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    let!(:answer) { create(:answer, question: question) }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: {question_id: question.id, id: answer, answer: attributes_for(:answer) }, format: :js
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

