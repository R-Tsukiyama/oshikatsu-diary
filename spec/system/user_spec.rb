require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let!(:user) { create(:user) }

  def login_user(user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "ログイン"
  end

  it "ログイン後にホームページにリダイレクトされること" do
    login_user(user)
    expect(page).to have_current_path(root_path)
    expect(page).to have_content("ログインしました。")
  end

  it "ログアウトリンクをクリックした際にセッションが削除され、ログアウトメッセージが表示されること" do
    login_user(user)
    find('.dropdown-toggle').click
    click_button "ログアウト"
    expect(page).to have_current_path(root_path)
    expect(page).to have_content("ログアウトしました。")
  end
end
