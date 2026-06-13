FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    association :author

    trait :with_genres do
      after(:create) do |book|
        create_list(:genre, 2).each do |genre|
          book.genres << genre
        end
      end
    end
  end
end
