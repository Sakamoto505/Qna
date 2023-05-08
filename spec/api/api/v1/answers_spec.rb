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
end
