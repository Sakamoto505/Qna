require 'rails_helper'

RSpec.describe ResultsController, type: :controller do
  describe 'GET #index_search' do
    let(:query) { 'search query' }

    context 'when search type is "questions"' do
      it 'performs search for questions' do
        expect(Question).to receive(:search_everywhere).with(query)
        get :index_search, params: { search_type: 'questions', query: query }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index_search)
      end
    end

    context 'when search type is "answers"' do
      it 'performs search for answers' do
        expect(Answer).to receive(:search_everywhere).with(query)
        get :index_search, params: { search_type: 'answers', query: query }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index_search)
      end
    end

    context 'when search type is "comments"' do
      it 'performs search for comments' do
        expect(Comment).to receive(:search_everywhere).with(query)
        get :index_search, params: { search_type: 'comments', query: query }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index_search)
      end
    end

    context 'when search type is "users"' do
      it 'performs search for users' do
        expect(User).to receive(:search_everywhere).with(query)
        get :index_search, params: { search_type: 'users', query: query }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index_search)
      end
    end

    context 'when search type is not specified' do
      it 'performs search for questions by default' do
        expect(Question).to receive(:search_everywhere).with(query)
        get :index_search, params: { query: query }
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index_search)
      end
    end
  end
end
