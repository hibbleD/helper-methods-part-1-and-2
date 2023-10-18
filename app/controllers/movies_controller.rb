class MoviesController < ApplicationController
  def new
    @the_movie = Movie.new

    render template: "movies/new"
  end

  def index
    @movies = Movie.order(created_at: :desc )

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html
    end
  end

  def show
    @the_movie = Movie.find(params.fetch(:id ))
  end

  def create
    @the_movie = Movie.new
    @the_movie.title = params.fetch("title")
    @the_movie.description = params.fetch("description")

    if @the_movie.valid?
      @the_movie.save
      redirect_to(movies_url, { notice: "Movie created successfully." })
    else
      render template: "movies/new"
    end
  end

  def edit
    @the_movie = Movie.find(params.fetch(:id))
  end

  def update
    @the_movie = Movie.find(params.fetch(:id))

    @the_movie.title = params.fetch("title")
    @the_movie.description = params.fetch("description")

    if @the_movie.valid?
      @the_movie.save
      redirect_to movie_url(@the_movie), notice: "Movie updated successfully."
    else
      redirect_to movie_url(@the_movie), alert:  "Movie failed to update successfully."
    end
  end

  def destroy
    @the_movie = Movie.find(params.fetch(:id))

    @the_movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end
