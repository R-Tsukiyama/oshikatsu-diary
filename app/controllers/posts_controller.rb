class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.includes(:tags).all.order(date: :desc)
    @user = current_user
  end

  def show
    @post = Post.find(params[:id])
    @tags = @post.tag_counts_on(:tags)
    @lat = @post.latitude
    @lng = @post.longitude
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      tag_list = params[:post][:tag_list]
      if tag_list.present?
        @post.tag_list.add(tag_list, parse: true)
        @post.save
      end
      redirect_to posts_path, notice: '新規投稿されました。'
    else
      flash[:error] = @post.errors.full_messages.to_sentence
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
    params.require(:post).permit(:title, :date, :caption, :address, :latitude, :longitude, :tag_list, :image)
  end
end
