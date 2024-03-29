# frozen_string_literal: true

require 'rails_helper'

describe 'Profiles API', type: :request do
  let(:headers) { { 'Content-Type': 'application/json', 'Accept': 'application/json' } }

  describe 'GET /api/v1/profiles/me' do
    let(:api_path) { '/api/v1/profiles/me' }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      before { get api_path, headers: headers, params: { access_token: access_token.token } }

      it 'returns 200 status code' do
        expect(response).to be_successful
      end

      it 'returns all public fields' do
        %w[id email created_at updated_at].each do |attr|
          expect(json['user'][attr]).to eq me.send(attr).as_json
        end
      end

      it 'does not return private fields' do
        %w[password encrypted_password].each do |attr|
          expect(json['user']).to_not have_key(attr)
        end
      end
    end
  end

  describe 'GET /api/v1/profiles' do
    let(:api_path) { '/api/v1/profiles' }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let!(:users) { create_list(:user, 3) }
      let(:user) { users.first }
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }
      let(:users_response) { json['users'].first }

      before { get api_path, headers: headers, params: { access_token: access_token.token } }

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns all users except authorized' do
        expect(json['users'].size).to eq 3
      end

      it 'returns users attributes' do
        %w[id email created_at updated_at].each do |attr|
          expect(users_response[attr]).to eq user.send(attr).as_json
        end
      end
      it 'does not return private fields' do
        %w[password encrypted_password].each do |attr|
          expect(users_response).to_not have_key(attr)
        end
      end
    end
  end
end
