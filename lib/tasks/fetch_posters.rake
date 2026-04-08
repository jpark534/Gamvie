namespace :movies do
  desc "Fetch movie posters from TMDB"
  task fetch_posters: :environment do
    require 'net/http'
    require 'json'

    api_key = ENV["TMDB_API_KEY"]
    base_url = "https://api.themoviedb.org/3/search/movie"
    image_base = "https://image.tmdb.org/t/p/w500"

    Movie.all.each do |movie|
      puts "Fetching poster for: #{movie.title}"

      uri = URI("#{base_url}?api_key=#{api_key}&query=#{URI.encode_www_form_component(movie.title)}")
      response = Net::HTTP.get(uri)
      data = JSON.parse(response)

      if data["results"] && data["results"].first && data["results"].first["poster_path"]
        poster_path = data["results"].first["poster_path"]
        movie.update!(poster_url: "#{image_base}#{poster_path}")
        puts "  ✓ Found poster"
      else
        puts "  ✗ No poster found"
      end

      sleep 0.3
    end

    puts "\nDone! #{Movie.where.not(poster_url: '').count} movies have posters."
  end
end