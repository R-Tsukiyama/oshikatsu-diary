class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @tags = @post.tag_counts_on(:tags) 
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      # タグを処理
      @post.tag_list.add(params[:post][:tag_list], parse: true)
      @post.save
      redirect_to @post, notice: '新規投稿されました。'
    else
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      @post.tag_list.add(params[:post][:tag_list], parse: true)
      @post.save
      redirect_to @post, notice: '投稿を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました。'
  end

  private

  def post_params
    params.require(:post).permit(:title, :caption, :address, :latitude, :longitude, :tag_list, :image)
  end
end
