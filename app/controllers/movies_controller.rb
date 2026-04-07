class MoviesController < ApplicationController
  def index
  end

  def recommend
    if request.get?
      redirect_to root_path and return
    end

    @input = params[:mood_input]
    matcher = MoodMatcher.new(@input)
    @detected_moods = matcher.detected_moods
    @movies = matcher.matching_movies
    render :index
  end
end