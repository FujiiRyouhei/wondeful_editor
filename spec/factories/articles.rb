FactoryBot.define do
  factory :article do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }
    user

    trait :with_comment do
      comment
    end
  end
end
