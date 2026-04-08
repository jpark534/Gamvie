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
    render :index
  end
  def api_recommendations
    input = params[:mood]
  
    if input.blank?
      render json: { error: "Please provide a mood parameter e.g. ?mood=happy" }, status: 400
      return
    end
  
    matcher = MoodMatcher.new(input)
    detected = matcher.detected_moods
    movies = matcher.matching_movies
  
    render json: {
      input: input,
      detected_moods: detected,
      results: movies.map do |m|
        {
          title: m.title,
          genre: m.genre,
          rating: m.rating,
          description: m.description,
          poster_url: m.poster_url,
          mood_tags: m.mood_tags.split(",")
        }
      end
    }
  end
end