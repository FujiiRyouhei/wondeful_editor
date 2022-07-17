FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    # encrypted_password { Faker::Internet.password }
    password { "password" }
    sequence(:email) { |n| "#{Faker::Internet.email}" }

    trait :with_article do
      article
    end

    trait :with_comment do
      comment
    end
  end
end
