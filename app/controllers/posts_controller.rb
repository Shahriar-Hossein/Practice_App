## the controller for posts
# Practice_App/app/controllers/posts_controller
class PostsController < ApplicationController
  #before_action :post_params, :create, :update
  load_and_authorize_resource param_method: :post_params

  def index ; end

  def show
    # raise @post.inspect
    @user = User.find(@post.user_id)
  end

  def new
    @current_user = current_user
  end

  def create
    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to @post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, status: :see_other
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :title, :body, :picture)
  end

end
