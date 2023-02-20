# frozen_string_literal: true

FactoryBot.define do
  factory :answer do
    body { 'Answer_Body' }
    question
    author factory: :user
  end

  trait :invalid_answer do
    body { nil }
  end
end
