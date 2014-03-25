class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:commenter, :text))
    redirect_to show_post_path(@user, @post)
  end
  
  def destroy
    @user = User.find(current_user.id)
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to show_post_path(@user, @post)
  end
  
  def like
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.like!
    redirect_to show_post_path(@user, @post)
  end
end
