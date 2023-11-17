FactoryBot.define do
    factory :user do
      email { 'test@example.com' }
      password { '111111' }
      password_confirmation { '111111' }
      username { 'test_user' }
    end
  end
