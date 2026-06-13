FactoryBot.define do
  factory :genre do
    name { Faker::Book.unique.genre }
    slug { name.parameterize }
  end
end
