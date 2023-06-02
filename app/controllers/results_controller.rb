class ResultsController < ApplicationController
  def index_search
    @search_results = PgSearch.multisearch(params[:query])
end
end
