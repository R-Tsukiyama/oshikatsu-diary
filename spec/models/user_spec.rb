require 'rails_helper'

RSpec.describe "User", type: :model do
  describe "ユーザー登録ができること" do
    let!(:user) { create(:user) }
    it 'name,email,password,password_confirmationが存在すれば登録できること' do
      expect(user).to be_valid
    end
  end
  describe "バリデーションのテスト" do
    it "名前が必須であること" do
      user = build(:user, username: nil)
      user.valid?
      expect(user.errors[:username]).to include("入力されていません。")
    end
    
    it "メールアドレスが必須であること" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("入力されていません。")
    end

    it "パスワードが必須であること" do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("入力されていません。")
    end
    
    it "パスワードと確認パスワードが一致している場合、ユーザーが有効であること" do
      user = build(:user, password: "password123", password_confirmation: "password123")
      expect(user).to be_valid
    end

    it "パスワードと確認パスワードが一致していない場合、ユーザーが無効であること" do
      user = build(:user, password: "password123", password_confirmation: "differentpassword")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("パスワード（確認用）が一致しません。")
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

