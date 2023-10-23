class CommentsController < ApplicationController

  load_and_authorize_resource param_method: :comment_params

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params) do |c|
      c.user = current_user
      c.commenter = current_user.email
    end
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post), status: :see_other
  end

  private

  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end

end
