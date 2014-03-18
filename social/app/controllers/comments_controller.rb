class CommentsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:text))
    redirect_to user_post_path(@user, @post)
  end
  
  def destroy
    @user = User.find(current_user.id)
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to user_post_path(@user, @post)
  end
end