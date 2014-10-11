# need if save for create and error messages if fail

class PostsController < ApplicationController
  def up_vote
    @post = Post.find(params[:id])
    Vote.up_vote!(@post, current_user)
    User.find(@post.user_id).notify!(:up_vote, current_user, @post.id)
    Activity.log_action(current_user, request.remote_ip.to_s,
      "post_up_vote", @post.id)
    redirect_to :back
  end
  
  def down_vote
    @post = Post.find(params[:id])
    Vote.down_vote!(@post, current_user)
    Activity.log_action(current_user, request.remote_ip.to_s,
      "post_down_vote", @post.id)
    redirect_to :back
  end
  
  def share
    @user = User.find(current_user.id)
    @other_user = User.find(Post.find(params[:id]).user_id)
    @post = @user.posts.create(original: params[:id])
    @other_user.notify!(:share_post, current_user, @post.id)
    Activity.log_action(current_user, request.remote_ip.to_s,
      "post_share", @post.id)
    redirect_to :back
  end
  
  def show
    @user = User.find(params[:user_id])
    if Post.find_by_id(params[:id])
      @post = Post.find(params[:id])
      @comments = @post.comments.sort_by(&:score).reverse!
      @comment = Comment.new
    end
    # logs data about visit
    Activity.log_action(current_user, request.remote_ip.to_s,
      "post_page_visit", @post.id)
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:post_id])
    
    if @post.update(params[:post].permit(:text, :image))
      redirect_to user_post_path(@post.user_id, @post)
    else
      flash[:error] = "Invalid input."
      redirect_to :back
    end
  end
  
  def create
    @post = current_user.posts.new(params[:post].permit(:text, :image))
    @post.group_id = params[:group_id]
    @text = @post.text
    if @post.save
      current_user.notify_mentioned(@post)
      Hashtag.extract(@post) if @text
      redirect_to :back
    else
      flash[:error] = "You can't post an empty post."
      redirect_to :back
    end
  end

  def destroy
    @user = User.find(current_user.id)
    @post = @user.posts.find(params[:id])
    @post.destroy
    Activity.log_action(current_user, request.remote_ip.to_s,
      "post_destroy", @post.id)
    redirect_to user_path(@user)
  end
end
