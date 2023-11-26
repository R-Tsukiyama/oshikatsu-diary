require 'rails_helper'

RSpec.describe "PostCreation", type: :system do
  let!(:user) { create(:user) }
  let!(:guest_user) { User.guest }

  before do
    sign_in user
  end

  it "タイトルが入力されていない場合にエラーメッセージが表示されること" do
    visit posts_new_path
    fill_in "post[title]", with: ""
    page.execute_script("document.getElementById('flatpickr').value = '2023-01-01'")
    click_button "投稿"

    expect(page).to have_content("入力されていません。")
  end

  it "日付が選択されていない場合にエラーメッセージが表示されること" do
    visit posts_new_path
    fill_in "post[title]", with: "新しい投稿のタイトル"
    click_button "投稿"

    expect(page).to have_content("日付を選択してください。")
  end
  
  it "日付が選択された場合、フォームに表示されること" do
    visit posts_new_path
    selected_date = "2023-01-15"
    page.execute_script("document.getElementById('flatpickr').value = '#{selected_date}'")

    expect(page).to have_field("post[date]", with: selected_date)
  end
  
  it "画像がアップロードされた際、プレビューされること" do
    visit posts_new_path
    image_file_path = Rails.root.join('spec', 'fixtures', 'image.jpg')
    attach_file "post[images][]", image_file_path, make_visible: true

    expect(page).to have_selector('.image-preview img', count: 1)
  end
  
  it "複数の画像をアップロードできること" do
    visit posts_new_path
    fill_in "post[title]", with: "複数画像の投稿"
    page.execute_script("document.getElementById('flatpickr').value = '2023-01-01'")
    image_files = [
        Rails.root.join('spec', 'fixtures', 'image1.jpg'),
        Rails.root.join('spec', 'fixtures', 'image2.jpg'),
        Rails.root.join('spec', 'fixtures', 'image3.jpg')
      ]
    attach_file "post[images][]", image_files, make_visible: true

    expect(page).to have_selector('.image-preview img', count: 3)
    click_button "投稿"

    new_post = Post.last
    expect(new_post.images.count).to eq(3)
  end
  
  it "ユーザーが場所を選択した場合、選択された場所と地図が表示されること" do
    visit posts_new_path
    fill_in "post[address]", with: "東京タワー"
    sleep(2)
    find(".pac-container .pac-item:first-child").click
    
    expect(page).to have_css('#map')
    expect(page).to have_css('.gm-style')
    expect(find_field("post[address]").value).to eq('日本、東京都港区芝公園４丁目２−８ 東京タワー')
  end

  it "ユーザーは新しい投稿を作成できること" do
    visit posts_new_path
    fill_in "post[title]", with: "新しい投稿のタイトル"
    page.execute_script("document.getElementById('flatpickr').value = '2023-01-01'")
    fill_in "post[caption]", with: "新しい投稿のキャプション"
    attach_file "post[images][]", Rails.root.join('spec', 'fixtures', 'image.jpg')
    fill_in "post[tag_list]", with: "タグ1, タグ2"
    fill_in "post[address]", with: "東京都渋谷区"
    click_button "投稿"

    expect(page).to have_current_path(posts_path)
    expect(page).to have_content("新規投稿されました。")
  end

  it "ゲストユーザーは新しい投稿を作成できること" do
    sign_in guest_user
    visit posts_new_path

    fill_in "post[title]", with: "ゲストユーザーの投稿"
    page.execute_script("document.getElementById('flatpickr').value = '2023-01-01'")
    fill_in "post[caption]", with: "ゲストユーザーの投稿のキャプション"
    attach_file "post[images][]", Rails.root.join('spec', 'fixtures', 'image.jpg')
    fill_in "post[tag_list]", with: "タグ1, タグ2"
    fill_in "post[address]", with: "東京都渋谷区"
    click_button "投稿"

    expect(page).to have_current_path(posts_path)
    expect(page).to have_content("新規投稿されました。")
  end
end
