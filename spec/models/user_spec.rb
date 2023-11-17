require 'rails_helper'

RSpec.describe "User", type: :model do
  describe "ユーザー登録ができること" do
    let!(:user) { create(:user) }
    
    it 'name,email,password,password_confirmationが存在すれば登録できること' do
      expect(user).to be_valid
    end
  end
end

