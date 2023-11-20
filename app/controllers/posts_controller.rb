class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :edit, :update]

  def index
    @posts = current_user.posts.includes(:tags).all.order(date: :desc)
    @user = current_user
  end

  def show
    @post = current_user.posts.includes(:tags, :images).find(params[:post_id])
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params.except(:images))
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
      
      @post = Post.includes(:tags, :images).find(@post.id)
      
      redirect_to posts_path, notice: '新規投稿されました。'
    else
      flash.now[:error] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @post = current_user.posts.find(params[:post_id])
    @deleted_images = [] 
  end

  def update
    @post = current_user.posts.find(params[:id])
    # 新しい画像を追加
    if params[:post][:images].present?
      @post.images.attach(params[:post][:images])
    end

    # 他の更新処理
    if @post.update(post_params.except(:images)) 
      redirect_to @post, notice: '再投稿しました。'
    else
      render :edit
    end
  end


  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: '投稿を削除しました。'
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
    params.require(:post).permit(
      :title,
      :date,
      :caption,
      :address,
      :latitude,
      :longitude,
      :tag_list,
      images: [],
      images_attachments_attributes: [ :id, :_destroy ]
      )
  end
end
