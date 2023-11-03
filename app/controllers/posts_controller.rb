## the controller for posts
# Practice_App/app/controllers/posts_controller
class PostsController < ApplicationController
  #before_action :post_params, :create, :update
  load_and_authorize_resource param_method: :post_params

  def index
    @posts = Post.all
    @posts = @posts.sort_by { | u | u.created_at }
  end

  def show
    @user = User.find(@post.user_id)
  end

  def new
    @user = current_user
  end

  def create
    if @post.save
      flash[:success] = "Post was successfully created!"
      redirect_to root_path
    else
      flash.now[:error] = "Post creation failed. Please check your input."
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = "Post was successfully created!"
      redirect_to @post
    else
      flash.now[:error] = "Please check your input."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, status: :see_other
  end

  private

  def post_params
    #raise @post.inspect
    params.require(:post).permit(:user_id, :title, :body, :picture)
  end

end
