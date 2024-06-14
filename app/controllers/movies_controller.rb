class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    m = Movie.new
    m.title = params.fetch("query_title")
    m.year = params.fetch("query_year")
    m.duration = params.fetch("query_duration")
    m.description = params.fetch("query_description")
    m.image = params.fetch("query_image")
    m.director_id = params.fetch("query_director_id")
    if (m.director_id && m.title)
      m.save
    end

    redirect_to("/movies")
  end

  def destroy
    the_id = params.fetch("an_id")
    matching_records = Movie.where({:id => the_id})
    the_movie = matching_records.at(0)
    the_movie.destroy

    redirect_to("/movies")
  end

  def update
    # Get the id out of params
    m_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Movie.where({:id=>m_id})
    m = matching_records.at(0)

    # overwrite each column with the values from user inputs
    m.title = params.fetch("query_title")
    m.year = params.fetch("query_year")
    m.duration = params.fetch("query_duration")
    m.description = params.fetch("query_description")
    m.image = params.fetch("query_image")
    m.director_id = params.fetch("query_director_id")
    # save
    m.save
    # redirect to the movie details
    redirect_to("/movies/#{m.id}")
  end
end
