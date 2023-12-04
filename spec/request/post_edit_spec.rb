require 'rails_helper'

RSpec.describe "Posts", type: :request do
    let!(:user) { create(:user) }
    let!(:guest_user) { User.guest }
    let!(:post) { create(:post, user: user) }
    let!(:guest_post) { create(:post, user: guest_user) }
    let(:valid_params) do
      { post: attributes_for(:post, title: "更新用タイトル") }
    end
    let(:invalid_params) do
      { post: attributes_for(:post, :invalid) }
    end


  describe "ユーザーの投稿編集について" do
    before do
      sign_in user
    end
    
    it "投稿の編集ページにアクセスできること" do
      get edit_post_path(post)
      expect(response).to have_http_status(200)
    end

    it "投稿の編集が成功すること" do
      patch post_path(post), params: valid_params
      expect(response).to redirect_to(post_path(post))
      expect(flash[:notice]).to eq('再投稿しました。')
      post.reload
      expect(post.title).to eq("更新用タイトル")
    end

    it "無効なパラメータで編集が失敗すること" do
      patch post_path(post), params: invalid_params
      expect(response).to render_template(:edit)
      post.reload
      expect(post.title).not_to eq(invalid_params[:post][:title])
    end
  end

  describe "ゲストユーザーの投稿編集について" do
    before do
      sign_in guest_user
    end

    it "投稿の編集ページにアクセスできること" do
      get edit_post_path(guest_post)
      expect(response).to have_http_status(200)
    end

    it "投稿の編集が成功すること" do
      patch post_path(guest_post), params: valid_params
      expect(response).to redirect_to(post_path(guest_post))
      expect(flash[:notice]).to eq('再投稿しました。')
      guest_post.reload
      expect(guest_post.title).to eq("更新用タイトル")
    end

    it "無効なパラメータで編集が失敗すること" do
      patch post_path(guest_post), params: invalid_params
      expect(response).to render_template(:edit)
      guest_post.reload
      expect(guest_post.title).not_to eq(invalid_params[:post][:title])
    end
  end

  describe "ユーザーの投稿削除について" do
    before do
      sign_in user
    end
  
    it "投稿を削除できること" do
      expect {
        delete post_path(post)
      }.to change { Post.count }.by(-1)
      expect(response).to redirect_to(posts_path)
    end
  end
  
  describe "ゲストユーザーの投稿削除について" do
    before do
      sign_in guest_user
    end
  
    it "投稿を削除できること" do
      expect {
        delete post_path(guest_post)
      }.to change { Post.count }.by(-1)
      expect(response).to redirect_to(posts_path)
    end
  end
end
