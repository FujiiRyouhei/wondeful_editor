FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    # encrypted_password { Faker::Internet.password }
    password { "password" }
    sequence(:email) {|_n| Faker::Internet.email.to_s }

    trait :with_article do
      article
    end

    trait :with_comment do
      comment
    end
  end
end
