# frozen_string_literal: true

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :votable, polymorphic: true
  validates_uniqueness_of :votable_id, scope: :user_id
end
