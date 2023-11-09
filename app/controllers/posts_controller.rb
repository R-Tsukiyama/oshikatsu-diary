class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update]

  def index
    @posts = Post.includes(:tags).all.order(date: :desc)
    @user = current_user
    @tags = Post.tag_counts_on(:tags).order('count DESC') 
    if @tag = params[:tag]
      @post = Post.tagged_with(params[:tag])
    end
  end

  def show
    @post = Post.includes(:tags, :images).find(params[:post_id])
    @tags = @post.tag_counts_on(:tags)
    @image = @post.images
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      if params[:post][:images].present?
        @post.images.purge
        params[:post][:images].each do |image|
          @post.images.attach(image)
        end
      end
      
      tag_list = params[:post][:tag_list]
      if tag_list.present?
        @post.tag_list.add(tag_list, parse: true)
      end
      redirect_to posts_path, notice: '新規投稿されました。'
    else
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:post_id])
  end

  def update
    @post = current_user.posts.find(params[:post_id])
    if params[:post][:images].present?
      @post.images.purge  # 既存の画像を削除
      params[:post][:images].each do |image|
        @post.images.attach(image)  # 新しい画像をアタッチ
      end
    end

        # 画像の削除処理
        if params[:post][:remove_images].present?
          params[:post][:remove_images].each do |image_id|
            image = @post.images.find_by(id: image_id)
            image.purge  # 画像を削除
          end
        end
    if @post.update(post_params)
      @post.tag_list.add(params[:post][:tag_list], parse: true)
      @post.save
      redirect_to @post, notice: '投稿を更新しました。'
    else
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:post_id])
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました。'
  end
  
  def destroy_image
    @post = Post.find(params[:post_id])
    image = @post.images.find(params[:image_id])
    image.purge
    redirect_to edit_post_path(@post), notice: '画像を削除しました'
  end
  
  def search_by_tag
    tag_name = params[:tag_name]
    @selected_tag = tag_name
    
    if tag_name.present?
      @posts = Post.includes(:tags).tagged_with(tag_name).order(date: :desc)
    else
      @posts = Post.includes(:tags).all.order(date: :desc)
    end
  
    render 'search_by_tag'
  end

  private

  def post_params
    params.require(:post).permit(:title, :date, :caption, :address, :latitude, :longitude, :tag_list, images: [])
  end
end
