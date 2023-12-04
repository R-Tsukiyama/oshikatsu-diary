FactoryBot.define do
  factory :post do
    title { "テストタイトル" }
    caption { "テストキャプション" }
    user_id { 1 }
    date { Date.today }
    
    trait :invalid do
      title { nil }
      date { nil }
    end
  end
end
