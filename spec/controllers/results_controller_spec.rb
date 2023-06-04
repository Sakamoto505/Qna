require 'rails_helper'

RSpec.describe ResultsController, type: :controller do
  describe 'GET index_search' do
    it 'assigns @search_results' do
      query = 'example query'
      results = [PgSearch::Document.new, PgSearch::Document.new]
      allow(PgSearch).to receive(:multisearch).with(query).and_return(results)

      get :index_search, params: { query: query }

      expect(assigns(:search_results)).to eq(results)
    end

    it 'renders the index_search template' do
      query = 'example query'
      results = [PgSearch::Document.new, PgSearch::Document.new]
      allow(PgSearch).to receive(:multisearch).with(query).and_return(results)

      get :index_search, params: { query: query }

      expect(response).to render_template(:index_search)
    end
  end
end
