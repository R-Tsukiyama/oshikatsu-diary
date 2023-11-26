require 'rails_helper'

RSpec.describe "User", type: :model do
  describe "ユーザー登録ができること" do
    let!(:user) { create(:user) }
    it 'name,email,password,password_confirmationが存在すれば登録できること' do
      expect(user).to be_valid
    end
  end
  describe "ゲストユーザー" do
    it "ゲストユーザーを生成すること" do
      guest_user = User.guest
      expect(guest_user.username).to eq("ゲストユーザー")
      expect(guest_user.email).to eq(User::GUEST_USER_EMAIL)
      expect(guest_user).to be_valid
    end
  end
end

