FactoryBot.define do
  factory :article do
    title { Faker::Lorem.word }
    body { Faker::Lorem.sentence }
    status { 0 }
    user

    trait :with_comment do
      comment
    end

    trait :draft do
      status { :draft }
    end

    trait :published do
      status { :published }
    end
  end
end
