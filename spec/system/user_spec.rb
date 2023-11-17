require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let!(:user) { create(:user) }
  
  it "ログイン後にホームページにリダイレクトされること" do
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "ログイン"
    expect(page).to have_current_path(root_path)
    expect(page).to have_content("ログインしました。")
  end
end
