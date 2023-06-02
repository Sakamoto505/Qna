FactoryBot.define do
  factory :search do
    searchable { nil }
    query { "MyString" }
  end
end
