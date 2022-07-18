FactoryBot.define do
  factory :comment do
    body { "ABC" }
    user
    article
  end
end
