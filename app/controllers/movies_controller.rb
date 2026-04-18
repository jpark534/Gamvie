class MoviesController < ApplicationController
  def index
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
  
    respond_to do |format|
      format.turbo_stream { render :index, status: :unprocessable_entity }
      format.html { render :index, status: :unprocessable_entity }
    end
  end
end