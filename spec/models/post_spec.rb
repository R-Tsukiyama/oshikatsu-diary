require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }

  describe "バリデーションの検証" do
    it "日付とタイトルが正しく設定されていること" do
      post = Post.new(title: "テストタイトル", caption: "テストキャプション", user: user, date: Date.today)
      expect(post).to be_valid
    end
    
    it "日付が設定されていない場合、無効であること" do
      post = Post.new(title: "テストタイトル", caption: "テストキャプション", user: user)
      expect(post).not_to be_valid
    end
    
    it "タイトルが設定されていない場合、無効であること" do
      post = Post.new(title: "", caption: "テストキャプション", user: user, date: Date.today)
      expect(post).not_to be_valid
    end
  end
    
  describe "画像のアップロード検証" do
    it "画像が正しくアップロードされていること" do
      post = Post.new(title: "テストタイトル", caption: "テストキャプション", user: user)
      file_path = Rails.root.join('spec', 'fixtures', 'image.jpg')
      post.images.attach(io: File.open(file_path), filename: 'image.jpg')
      expect(post.images).to be_attached
      expect(post.images).to be_an_instance_of(ActiveStorage::Attached::Many)
      expect(post.images.first.blob.content_type).to eq('image/jpeg')
    end
  end
    
  describe "タグの検証" do
    it "タグが正しく設定されていること" do
      post = Post.new(title: "テストタイトル", caption: "テストキャプション", user: user, tag_list: "タグ1, タグ2")
      post.save
      expect(post.tag_list).to eq(["タグ1", "タグ2"])
    end
    
    it "タグが設定されていない場合、空であること" do
      post = Post.new(title: "テストタイトル", caption: "テストキャプション", user: user)
      expect(post.tag_list).to be_empty
    end
    
    it "重複するタグは排除されること" do
      post = Post.new(title: "テストタイトル", caption: "テストキャプション", user: user, tag_list: "タグ1, タグ1, タグ2")
      post.save
      expect(post.tag_list).to eq(["タグ1", "タグ2"])
    end
    
    it "特定のタグを持つ投稿が正しく検索されること" do
      tagged_post = create(:post, user: user, tag_list: "特定のタグ")
      untagged_post = create(:post, user: user)
    
      posts_with_specific_tag = Post.tagged_with("特定のタグ")
      expect(posts_with_specific_tag).to include(tagged_post)
      expect(posts_with_specific_tag).not_to include(untagged_post)
    end
    
    it "タグが整形されること" do
      post = Post.new(title: "テストタイトル", caption: "テストキャプション", user: user, tag_list: "タグ1, 他のタグ, タグ2")
      post.save
      expect(post.tag_list).to eq(["タグ1", "他のタグ", "タグ2"])
    end
  end
end
