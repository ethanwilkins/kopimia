class CommentsController < ApplicationController
  
  def up_vote
    @comment = Comment.find(params[:id])
    Vote.up_vote!(@comment, current_user)
    redirect_to :back
  end
  
  def down_vote
    @comment = Comment.find(params[:id])
    Vote.down_vote!(@comment, current_user)
    redirect_to :back
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(params[:comment].permit(:text))
		@comment.commenter = current_user
		if @comment.save
      User.find(@post.user).notify!(:comment, current_user, @post.id)
  	  redirect_to :back
		else
 	   render "posts/show"
		end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end
end
