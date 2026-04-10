class MoviesController < ApplicationController
  def index
    if session[:last_results].present?
      @input = session[:last_results]["input"]
      @detected_moods = session[:last_results]["detected_moods"]
      movie_ids = session[:last_results]["movie_ids"]
      @movies = Movie.where(id: movie_ids).sort_by { |m| movie_ids.index(m.id) }
      session[:last_results] = nil
    end
  end

  def recommend
    @input = params[:mood_input]
    @shuffle = params[:shuffle] == "true"
    matcher = MoodMatcher.new(@input)
    @detected_moods = matcher.detected_moods
    all_matches = matcher.matching_movies(shuffle: true)

    if @shuffle
      previously_shown = session[:shown_movie_ids] || []
      remaining = all_matches.reject { |m| previously_shown.include?(m.id) }
      remaining = all_matches if remaining.length < 3
      @movies = remaining.first(5)
    else
      @movies = all_matches.first(5)
    end

    session[:shown_movie_ids] = @movies.map(&:id)
    session[:last_results] = {
      "input" => @input,
      "detected_moods" => @detected_moods,
      "movie_ids" => @movies.map(&:id)
    }

    redirect_to root_path
  end
end