require 'rails_helper'

RSpec.describe "Posts", type: :request do
  let!(:user) { create(:user) }
  let!(:guest_user) { User.guest }

  describe "ユーザーの新規投稿について" do
    before do
      sign_in user
    end

    subject { post(posts_path, params: params) }

    context 'パラメータが正常な場合' do
      let(:params) { { post: attributes_for(:post) } }

      it '投稿が保存される' do
        expect { subject }.to change { Post.count }.by(1)
      end

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(302)
      end

      it '投稿一覧ページにリダイレクトされる' do
        subject
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'パラメータが異常な場合' do
      let(:params) { { post: attributes_for(:post, :invalid) } }

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(200)
      end

      it '投稿が保存されない' do
        expect { subject }.not_to change(Post, :count)
      end

      it '新規投稿ページがレンダリングされる' do
        subject
        expect(response).to render_template(:new)
      end
    end
  end
  
  describe "ゲストユーザーの新規投稿について" do
    before do
      sign_in guest_user
    end

    subject { post(posts_path, params: params) }

    context 'パラメータが正常な場合' do
      let(:params) { { post: attributes_for(:post) } }

      it '投稿が保存される' do
        expect { subject }.to change { Post.count }.by(1)
      end

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(302)
      end

      it '投稿一覧ページにリダイレクトされる' do
        subject
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'パラメータが異常な場合' do
      let(:params) { { post: attributes_for(:post, :invalid) } }

      it 'リクエストが成功する' do
        subject
        expect(response).to have_http_status(200)
      end

      it '投稿が保存されない' do
        expect { subject }.not_to change(Post, :count)
      end

      it '新規投稿ページがレンダリングされる' do
        subject
        expect(response).to render_template(:new)
      end
    end
  end
end
