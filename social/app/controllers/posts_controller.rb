# need if save for create and error messages if fail

class PostsController < ApplicationController
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
  
  def like
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post.like!
    #creates notification
    @user.notify!(:like_post, current_user, @post.id)
    redirect_to :back
  end
  
  def share
    @user = User.find(current_user.id)
    @post = @user.posts.create(original: params[:id])
    redirect_to :back
  end
end
