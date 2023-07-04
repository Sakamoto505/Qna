# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :user
  include PgSearch::Model
  multisearchable against: :body

  validates :body, presence: true
end
