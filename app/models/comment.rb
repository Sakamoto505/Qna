# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  include PgSearch::Model
  pg_search_scope :search_everywhere, against: [:body]

  validates :body, presence: true
end
