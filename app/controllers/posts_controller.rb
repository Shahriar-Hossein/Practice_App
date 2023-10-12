## the controller for posts
# Practice_App/app/controllers/posts_controller
class PostsController < ApplicationController
  #before_action :post_params, :create, :update
  load_and_authorize_resource param_method: :post_params

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to posts_path, status: :see_other
  end

  private

  def post_params
    #raise @post.inspect
    params.require(:post).permit(:user_id, :title, :body)
  end

end
