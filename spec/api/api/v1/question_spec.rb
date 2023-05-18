# frozen_string_literal: true

require 'rails_helper'

describe 'Question API', type: :request do
  let(:headers) do
    { 'Content-Type': 'application/json',
      'Accept': 'application/json' }
  end
  describe 'GET /api/v1/questions' do
    let(:api_path) { '/api/v1/questions' }
    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end
    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let(:question_response) { json['questions'].first }
      let!(:answers) { create_list(:answer, 3, question: question) }
      before { get '/api/v1/questions', params: { access_token: access_token.token }, headers: headers }
      it 'returns 200 status code' do
        expect(response).to be_successful
      end
      it 'returns list of questions' do
        expect(json['questions'].size).to eq 2
      end

      it 'returns all public fields' do
        %w[id title body created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end
      describe 'answers' do
        let(:answer) { answers.first }
        let(:answer_response) { question_response['answers'].first }
        it 'returns list of answers' do
          expect(question_response['answers'].size).to eq 3
        end
        it 'returns all public fields' do
          %w[id body created_at updated_at].each do |attr|
            expect(answer_response[attr]).to eq answer.send(attr).as_json
          end
        end
      end
    end
  end

  describe 'GET /api/v1/questions/{id}' do
    let!(:question) { create(:question, :question_with_file) }
    let(:api_path) { "/api/v1/questions/#{question.id}" }
    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:access_token) { create(:access_token) }
      let(:question_response) { json['question'] }
      let!(:links) { create_list(:link, 3, linkable: question) }
      before { get api_path, params: { access_token: access_token.token }, headers: headers }
      it 'returns 200 status code' do
        expect(response).to be_successful
      end
      it 'returns all public fields' do
        %w[id title body created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end

      it 'does not return private fields of question' do
        %w[user_id].each do |attr|
          expect(question_response).to_not have_key(attr)
        end
      end
    end
  end

  describe 'POST /api/v1/questions' do
    let(:api_path) { '/api/v1/questions' }
    let(:user) { create(:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }

    context 'authorized' do
      context 'with valid attributes' do
        let(:valid_attributes) { { question: { title: 'Question_title', body: 'Question_body' } } }

        it 'returns 201 status code' do
          post api_path, params: valid_attributes.merge(access_token: access_token.token)

          expect(response).to have_http_status(:created)
        end
      end
    end
  end

  describe 'PATCH /api/v1/questions/:id' do
    let!(:question) { create(:question) }
    let(:access_token) { create(:access_token) }
    let(:api_path) { "/api/v1/questions/#{question.id}" }

    before do
      patch api_path, params: { question: { title: 'Question_title' } },
                      headers: { 'Authorization' => "Bearer #{access_token.token}" }
    end
    #Не работает
    it 'returns 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'updates the question' do
      question.reload
      expect(question.title).to eq('Question_title')
    end
  end

  describe 'DELETE /api/v1/questions/:id' do
    let!(:user) { create(:user) }
    let!(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let!(:question) { create(:question, author: user) }
    let(:api_path) { "/api/v1/questions/#{question.id}" }

    before do
      delete api_path, params: { access_token: access_token.token }
    end

    it 'returns 204 status code' do
      expect(response).to have_http_status(:no_content)
    end

    it 'deletes the question' do
      expect(Question.exists?(question.id)).to be_falsey
    end

    it 'reduces the number of user questions by 1' do
      expect(user.questions.count).to eq(0)
    end
  end
end
