# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  include PgSearch
  multisearchable against: :body

  after_save :reindex

  validates :body, presence: true

  def reindex
    PgSearch::Multisearch.rebuild(Hero)
  end
end
