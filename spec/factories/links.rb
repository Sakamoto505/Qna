# frozen_string_literal: true

FactoryBot.define do
  sequence :url do |n|
    "http://#{n}"
  end

  factory :link do
    name { 'MyString' }
    url
  end
end
