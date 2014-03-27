class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment].permit(:text))
		@comment.commenter = current_user
		if @comment.save
  	  redirect_to show_post_path(@post.user, @post)
		else
 	   render "posts/show"
		end
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
