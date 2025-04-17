class CommentsController < ApplicationController
    
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        redirect_to posts_path, notice: "Comment added"
      else
        redirect_to posts_path, alert: "Could not add comment"
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  end
  
