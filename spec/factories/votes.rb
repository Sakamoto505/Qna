# frozen_string_literal: true

FactoryBot.define do
  factory :vote do
    user { nil }
    votable { nil }
    value { 1 }
  end
end
