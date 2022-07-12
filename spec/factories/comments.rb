FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user_id { "" }
    article_id { "" }
  end
end
