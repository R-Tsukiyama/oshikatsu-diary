class PostsController < ApplicationController
   before_action :set_post, only: [:show, :edit, :update, :destroy]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      # タグを処理
      @post.tag_list.add(params[:post][:tag_list], parse: true)
      @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  # 投稿を更新するアクション
  def update
    if @post.update(post_params)
      @post.tag_list.add(params[:post][:tag_list], parse: true)
      @post.save
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました。'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :caption, :location, :tag_list, :image)
  end
end
