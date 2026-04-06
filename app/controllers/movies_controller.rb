class MoviesController < ApplicationController
  def index
    if user_signed_in?
      @past_searches = current_user.mood_searches.order(created_at: :desc).limit(5)
    end
  end

  def recommend
    @input = params[:mood_input]
    matcher = MoodMatcher.new(@input)
    @detected_moods = matcher.detected_moods
    @movies = matcher.matching_movies

    if user_signed_in?
      current_user.mood_searches.create!(
        mood_input: @input,
        detected_moods: @detected_moods.join(", "),
        movies_matched: @movies.count
      )
      @past_searches = current_user.mood_searches.order(created_at: :desc).limit(5)
    end

    render :index
  end
end