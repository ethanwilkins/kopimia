# need if save for create and error messages if fail

class PostsController < ApplicationController
  
  def up_vote
    @post = Post.find(params[:id])
    Vote.up_vote!(@post, current_user)
    redirect_to :back
  end
  
  def down_vote
    @post = Post.find(params[:id])
    Vote.down_vote!(@post, current_user)
    redirect_to :back
  end
  
  def share
    @user = User.find(current_user.id)
    @other_user = User.find(Post.find(params[:id]).user_id)
    @post = @user.posts.create(original: params[:id])
    @other_user.notify!(:share_post, current_user, @post.id)
    redirect_to :back
  end
  
  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @comments = @post.comments.sort_by(&:score).reverse!
    @comment = Comment.new
  end
  
  def create
    @user = User.find(current_user.id)
    @post = @user.posts.new(params[:post].permit(:text, :image))
    @post.group_id = params[:group_id]
    @text = @post.text
    if @post.save
      if @text
        # extracts hashtags from post.text
        @text.split(' ').each do |tag|
          if tag.include? "#"
            # removes tag from text
            @text.slice! tag
            # @post would not update
            Post.find(@post.id).update(text: @text)
            # pushes each tag into post
            @post.hashtags.create(tag: tag)
          end
        end
      end
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
