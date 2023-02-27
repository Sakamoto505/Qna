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

  trait :answer_with_file do
    files { [Rack::Test::UploadedFile.new("#{Rails.root}/spec/rails_helper.rb", 'text/x-ruby')] }
  end
end
