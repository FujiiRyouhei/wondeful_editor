FactoryBot.define do
  factory :article do
    title { "ABC" }
    body { "ABC" }
    user

    trait :with_comment do
      comment
    end
  end
end
