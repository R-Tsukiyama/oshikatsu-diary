require 'rails_helper'

RSpec.describe "PostEdit", type: :system do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, user: user) }
  
  before do
    sign_in user
  end
  
  it "投稿の編集ができること" do
    visit edit_post_path(post)

    fill_in "post[title]", with: "更新されたタイトル"
    page.execute_script("document.getElementById('flatpickr').value = '2023-01-02'")
    fill_in "post[caption]", with: "更新されたキャプション"
    attach_file "post[images][]", Rails.root.join('spec', 'fixtures', 'updated_image.jpg')
    fill_in "post[tag_list]", with: "更新タグ1, 更新タグ2"
    fill_in "post[address]", with: "更新された場所"
    click_button "更新"

    expect(page).to have_current_path(post_path(post))
    expect(page).to have_content("再投稿しました。")

    expect(page).to have_content("更新されたタイトル")
    expect(page).to have_content("更新されたキャプション")
    expect(page).to have_content("更新タグ1")
    expect(page).to have_content("更新タグ2")
    expect(page).to have_content("更新された場所")

    updated_post = Post.find_by(title: "更新されたタイトル")
    expect(updated_post.images.count).to eq(1)
  end
  
  it "編集時にタイトルが入力されていない場合にエラーメッセージが表示されること" do
    visit edit_post_path(post)
    fill_in "post[title]", with: ""
    click_button "更新"

    expect(page).to have_content("入力されていません。")
  end
end
