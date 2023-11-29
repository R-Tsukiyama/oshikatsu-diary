require 'rails_helper'

RSpec.describe "Home", type: :system do

  it "ホーム画面が表示されること" do
    visit root_path
    
    expect(page).to have_content("推し活日記")
    expect(page).to have_selector(".DiaryFeature", count: 4)
    expect(page).to_not have_selector("#calendarDetails")
    expect(page).to_not have_selector("#mapDetails")
    expect(page).to_not have_selector("#imagesDetails")
    expect(page).to_not have_selector("#tagsDetails")
  end

  describe "ホーム画面でのクリックイベント" do
    it "「カレンダー形式で推し活動を記録」コンテンツをクリックすると詳細が表示されること" do
      visit root_path
      page.execute_script("toggleDetails('calendar')")

      expect(page).to have_selector("#calendarDetails")
      within "#calendarDetails" do
        expect(page).to have_text("手帳のようにカレンダー形式で投稿管理ができます。\n思い出が振り返りやすくなります。")
        expect(page).to have_css("img[src*='caption_calendar'][alt='カレンダーのスクリーンショット'].caption-feature")
      end
      expect(page).to_not have_selector("#mapDetails")
      expect(page).to_not have_selector("#imagesDetails")
      expect(page).to_not have_selector("#tagsDetails")
    end

    it "「場所情報を追加」コンテンツをクリックすると詳細が表示されること" do
      visit root_path
      page.execute_script("toggleDetails('map')")

      expect(page).to have_selector("#mapDetails")
      within "#mapDetails" do
        expect(page).to have_text("「GoogleMap」を使用した場所情報を追加できます。")
        expect(page).to have_css("img[src*='caption_map'][alt='地図入力のGIF'].caption-feature")
      end
      expect(page).to_not have_selector("#calendarDetails")
      expect(page).to_not have_selector("#imagesDetails")
      expect(page).to_not have_selector("#tagsDetails")
    end

    it "「写真を添付」コンテンツをクリックすると詳細が表示されること" do
      visit root_path
      page.execute_script("toggleDetails('images')")

      expect(page).to have_selector("#imagesDetails")
      within "#imagesDetails" do
        expect(page).to have_text("写真を添付できます。\nもちろん文章だけの投稿も可能です。")
        expect(page).to have_css("img[src*='caption_post1'][alt='投稿例1'].caption-feature-post")
        expect(page).to have_css("img[src*='caption_post2'][alt='投稿例2'].caption-feature-post")
        expect(page).to have_css("img[src*='caption_post'][alt='投稿例3'].caption-feature-post")
      end
      expect(page).to_not have_selector("#calendarDetails")
      expect(page).to_not have_selector("#mapDetails")
      expect(page).to_not have_selector("#tagsDetails")
    end

    it "「タグ機能で簡単絞り込み」コンテンツをクリックすると詳細が表示されること" do
      visit root_path
      page.execute_script("toggleDetails('tags')")

      expect(page).to have_selector("#tagsDetails")
      within "#tagsDetails" do
        expect(page).to have_text("登録したタグをクリックすると、\n同じタグの投稿を簡単に見つけられます。")
        expect(page).to have_css("img[src*='caption_tag'][alt='タグのGIF']")
      end
      expect(page).to_not have_selector("#calendarDetails")
      expect(page).to_not have_selector("#mapDetails")
      expect(page).to_not have_selector("#imagesDetails")
    end
  end
end
