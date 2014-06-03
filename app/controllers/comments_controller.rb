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
    if params[:post_id]
      @item = Post.find(params[:post_id])
    elsif params[:proposal_id]
      @item = Proposal.find(params[:proposal_id])
    end
    @comment = @item.comments.new(params[:comment].permit(:text))
		@comment.commenter = current_user
		if @comment.save
      User.find(@item.user_id).notify!(:comment, current_user, @item.id) if @item.user_id
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
