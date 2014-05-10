# need if save for create and error messages if fail

class PostsController < ApplicationController
  
  def up_vote
    @post = Post.find(params[:id])
    @post.up_vote!(current_user)
    redirect_to :back
  end
  
  def down_vote
    @post = Post.find(params[:id])
    @post.down_vote!(current_user)
    redirect_to :back
  end
  
  def share
    @user = User.find(current_user.id)
    @other_user = User.find(Post.find(params[:id]).user_id)
    @post = @user.posts.create(original: params[:id])
    # @other_user.notify!(:share_post, current_user, @post.id)
    redirect_to :back
  end
  
  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comment = Comment.new
  end
  
  def create
    @user = User.find(current_user.id)
    @post = @user.posts.new(params[:post].permit(:text, :image))
    
    if @post.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to user_path(@user)
  end
end
