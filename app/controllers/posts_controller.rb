class PostsController < ApplicationController
    
    def index
        followed_ids = current_user.sent_follow_requests
        .where(status: 'accepted')
        .pluck(:receiver_id)
      
        visible_user_ids = followed_ids + [current_user.id]
        Rails.logger.debug "✅ VISIBLE IDS: #{visible_user_ids}"
      
        @posts = Post.where(user_id: visible_user_ids).order(created_at: :desc)
    end
    
    def new 
        @post = Post.new
    end

    def show
        @post = Post.find(params[:id])
        @comment = Comment.new
    end

    def create
        @post = Post.new(post_params)
        @post.user = current_user

        if @post.save
            redirect_to posts_path
        else 
            render :new, status: :unprocessable_entity
        end
    end

    private

    def post_params
        params.require(:post).permit(:content)
    end    
end
