class LikesController < ApplicationController
    before_action :set_post
  
    def create
      @post.likes.create(user: current_user)
      redirect_to post_path(@post)
    end
  
    def destroy
      @post.likes.where(user: current_user).destroy_all
      redirect_to post_path(@post)
    end
  
    private
  
    def set_post
      @post = Post.find(params[:post_id])
    end
  end
  
