class MovieController < ApplicationController
  def index
    @movies = Movie.all

    respond_to do |format|
      format.html  # index.html.erb
      format.json { render :json => @movies }
    end
  end

  def actors
    @actors = Actor.joins(:casts).where(["movie_id=?", params[:id]])

    respond_to do |format|
      format.html  # index.html.erb
      format.json { render :json => @actors }
      format.js  { render :text => "#{params[:jsonp]}(#{@actors.to_json});" }
    end
  end

end
