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
  
  def show
    @comment = Comment.new
    @_comment = Comment.find(params[:id])
    @replies = Comment.where(comment_id: params[:id])
  end
  
  def create
    # @item is item being commented on
    if params[:post_id]
      @item = Post.find(params[:post_id])
      comment_type = :comment
    elsif params[:comment_id]
      @item = Comment.find(params[:comment_id])
      comment_type = :reply
    elsif params[:proposal_id]
      @item = Proposal.find(params[:proposal_id])
      comment_type = :comment_proposal
    elsif params[:module_id]
      @item = CodeModule.find(params[:module_id])
      comment_type = :comment_module
    elsif params[:share_id]
      @item = Share.find(params[:share_id])
      comment_type = :comment_share
    end
    @comment = @item.comments.new(params[:comment].permit(:text))
		@comment.commenter = current_user
		if @comment.save
      Hashtag.extract(@comment)
      if @item.user_id
        User.find(@item.user_id).notify!(comment_type, current_user, @item.id)
      elsif @item.commenter
        User.find(@item.commenter).notify!(comment_type, current_user, @item.id)
      end
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
