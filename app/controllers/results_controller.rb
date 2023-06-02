class ResultsController < ApplicationController
  def index_search
    search_type = params[:search_type]

    @search_results =
      case search_type
      when 'questions'
        Question.search_everywhere(params[:query])
      when 'answers'
        Answer.search_everywhere(params[:query])
      when 'comments'
        Comment.search_everywhere(params[:query])

      when 'users'
        User.search_everywhere(params[:query])
      else
        Question.search_everywhere(params[:query])
      end
  end
end
