class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:index,:show]
  def index
    @post=Post.all.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
  end
  
  def new
    @post=current_user.posts.build
  end
  
  def edit
    @post=Post.find(params[:id])
  end
  
  def update
    @post=Post.find(params[:id])
    
    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit' 
    end
  end
  
  
  def create
    @post=current_user.posts.build(post_params)
    
    if @post.save
    redirect_to @post
    else
      render 'new' 
    end 
  end
  
  def show
    @post=Post.find(params[:id])
  end
  
  def destroy
    @post=Post.find(params[:id])
    
    @post.destroy
    redirect_to root_path
  end
  
  
  
  private
  def post_params
    params.require(:post).permit(:title,:body)
  end
  
  
end
