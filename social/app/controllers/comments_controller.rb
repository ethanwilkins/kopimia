class CommentsController < ApplicationController
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
  
  def like
    @comment = Comment.find(params[:id])
    @comment.like!
    # notify commenter their comment was liked
    @commenter = User.find(@comment.commenter)
    @commenter.notify!(:like_comment, current_user, @comment.post_id)
    redirect_to :back
  end
end
