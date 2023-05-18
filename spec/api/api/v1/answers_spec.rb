# frozen_string_literal: true

require 'rails_helper'

describe 'Answers API', type: :request do
  let(:headers) { { 'Content-Type': 'application/json', 'Accept': 'application/json' } }

  describe 'GET /api/v1/questions/{id}/answers' do
    let!(:question) { create(:question) }
    let!(:answers) { create_list(:answer, 5, question: question) }
    let(:answer) { answers.first }
    let(:api_path) { "/api/v1/questions/#{question.id}/answers" }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let(:answer_response) { json['answers'].first }

      before { get api_path, params: { access_token: access_token.token }, headers: headers }

      it 'returns 200 status code' do
        expect(response).to be_successful
      end

      it 'returns list of answers' do
        expect(json['answers'].size).to eq answers.size
      end

      it 'returns all public fields of answer' do
        %w[id body created_at updated_at].each do |attr|
          expect(answer_response[attr]).to eq answer.send(attr).as_json
        end
      end

      it 'does not return private fields of answer' do
        %w[user_id].each do |attr|
          expect(answer_response).to_not have_key(attr)
        end
      end
    end
  end

  describe "GET /api/v1/questions/#{id}/answers/#{id}" do
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let(:api_path) { "/api/v1/questions/#{question.id}/answers/#{answer.id}.json" }
    let(:user) { create(:user) }
    let(:question) { create(:question, author_id: user.id) }
    let(:answer) { create(:answer, question_id: question.id, author_id: user.id) }
    let(:comments) { create_list(:comment, commentable: answer, user: user) }
    let(:links) { create_list(:link, linkable: answer) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    before { get api_path, params: { access_token: access_token.token }, headers: headers }

    context 'authorized' do
      it 'contains answer fields' do
        %w[id body created_at updated_at].each do |attr|
          expect(json['answer'][attr]).to eq answer.send(attr).as_json
        end
      end

      it 'contains answer comments files links' do
        %w[comments files links].each do |attr|
          expect(json['answer'][attr].size).to eq answer.send(attr).size
        end
      end
    end
  end

  describe 'PATCH /api/v1/questions/:question_id/answers/:id' do
    let(:user) { create(:user) }
    let(:question) { create(:question, author_id: user.id) }
    let(:answer) { create(:answer, question_id: question.id, author_id: user.id) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let(:api_path) { "/api/v1/questions/#{question.id}/answers/#{answer.id}" }
    it 'updates the answer' do
      patch api_path, params: { answer: { body: 'Updated answer body' } },
                      headers: { 'Authorization': "Bearer #{access_token.token}" }

      expect(response).to have_http_status(:ok)
      expect(answer.reload.body).to eq('Updated answer body')
    end
  end

  describe 'DELETE /api/v1/answers/:id' do
    let(:user) { create(:user) }
    let(:question) { create(:question, author_id: user.id) }
    let(:answer) { create(:answer, question_id: question.id, author_id: user.id) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let(:api_path) { "/api/v1/questions/#{question.id}/answers/#{answer.id}" }

    context 'authorized' do
      before do
        delete api_path, params: { access_token: access_token.token },
                         headers: { 'Authorization': "Bearer #{access_token.token}" }
      end

      it 'deletes the answer' do
        expect(response).to have_http_status(:no_content)
        expect(Answer.exists?(answer.id)).to be_falsey
      end
    end
  end
end
