class PostsController < ApplicationController
  def index
    @posts = Post.all
    respond_to do |format|
      format.json {render :json => @posts}
    end
  end

  def create
    debugger
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.json {render :json => @post}
      else
        format.json {render :json => {}}
      end
    end
  end
end
