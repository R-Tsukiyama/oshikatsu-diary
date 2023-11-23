FactoryBot.define do
  factory :post do
    title { "テストタイトル" }
    caption { "テストキャプション" }
    user_id { 1 }
    date { Date.today }
  end
end
