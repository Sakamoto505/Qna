class Search < ApplicationRecord
  include PgSearch::Model

  belongs_to :searchable, polymorphic: true

  multisearchable against: [:query]
end
