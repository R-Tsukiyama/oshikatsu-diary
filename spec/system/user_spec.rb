require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  let!(:user) { create(:user) }
  
  def login_user(user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "ログイン"
  end

  describe "ログイン・ログアウト機能" do
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
  
  describe "ユーザー編集" do
    before do
      login_user(user)
      visit edit_user_path(user)
    end
    
    it "ユーザーはプロフィール情報を編集と保存ができること" do
      attach_file 'user[userimage]', File.join(Rails.root, 'spec/fixtures/test-avatar.png')
      fill_in "user[username]", with: "New Username"
      fill_in "user[profile]", with: "This is a new profile."
      click_button "保存"

      expect(page).to have_content("更新しました。")
      
      user_name_element = find('.userinformation .username')
      expect(user_name_element).to have_content('New Username')
      expect(page).to have_selector('.userinformation .profile-image[src*="test-avatar.png"]')
      expect(page).to have_css('.AccountItem p', text: 'New Username')
      expect(page).to have_css('.AccountItem img[src*="test-avatar.png"]')
    end

    it "ユーザーは無効なプロフィール情報を保存できないこと" do
      fill_in "user[username]", with: ""
      click_button "保存"

      expect(page).to have_content("名前を入力してください。")
    end
  end
end
