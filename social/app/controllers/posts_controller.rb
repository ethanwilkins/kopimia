class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @user = User.find(current_user.id)
    @post = @user.posts.create(params[:post].permit(:text))
    redirect_to user_path(@user)
  end

  def destroy
    @user = User.find(current_user.id)
    @post = @user.posts.find(params[:id])
    @post.destroy
    redirect_to user_path(@user)
  end
end
