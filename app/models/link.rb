# frozen_string_literal: true

class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, presence: true
  validates :url, presence: true, format: URI::DEFAULT_PARSER.make_regexp(%w[http https])

  def gist?
    url.match?(%r{^(https?://)?gist\.github\.com/(\w+/)?\w+$})
  end
end
