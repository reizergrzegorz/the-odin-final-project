class PostsController < ApplicationController
    
    def index
        #@posts = current_user.posts.all
        @posts = Post.all
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
