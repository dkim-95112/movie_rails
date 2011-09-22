class ActorController < ApplicationController
  def index
    @actors = Actor.all

    respond_to do |format|
      format.html  # index.html.erb
      format.json { render :json => @actors }
    end
  end

  def movies
    @movies = Movie.joins(:casts).where(["actor_id=?", params[:id]])

    respond_to do |format|
      format.html  # index.html.erb
      format.json { render :json => @movies }
    end
  end
end
