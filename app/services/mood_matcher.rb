class MoodMatcher
  MOOD_KEYWORDS = {
    "heartbreak"  => ["rejected", "breakup", "broke up", "heartbroken", "miss her", "miss him", "dumped", "lonely", "alone"],
    "sad"         => ["sad", "crying", "depressed", "unhappy", "miserable", "devastated", "hurt"],
    "happy"       => ["happy", "great", "amazing", "excited", "celebrate", "celebration", "good mood"],
    "motivated"   => ["motivated", "grind", "hustle", "working hard", "ambitious", "goal", "productive"],
    "bored"       => ["bored", "nothing to do", "boring", "tired", "meh", "whatever"],
    "anxious"     => ["anxious", "nervous", "stressed", "overwhelmed", "panic", "worried", "anxiety"],
    "hopeful"     => ["hopeful", "better", "optimistic", "looking up", "new start", "fresh"],
    "existential" => ["meaning", "purpose", "why", "life", "exist", "universe", "deep thoughts"],
    "cozy"        => ["cozy", "rainy", "blanket", "tea", "coffee", "chill", "relax", "lazy", "background"],
    "adventure"   => ["adventure", "travel", "explore", "outdoors", "something new"],
    "wonder"      => ["wonder", "inspired", "beautiful", "amazing", "mind blown", "interstellar"],
    "funny"       => ["funny", "laugh", "comedy", "humor", "fun", "lol"],
    "nostalgic"   => ["nostalgic", "childhood", "memories", "old times", "remember when"],
    "focused"     => ["studying", "study", "focus", "concentrate", "work", "background", "noise"],
    "lost"        => ["lost", "confused", "direction", "don't know", "unsure", "what to do"]
  }

  def initialize(input)
    @input = input.downcase
  end

  def detected_moods
    moods = []
    MOOD_KEYWORDS.each do |mood, keywords|
      keywords.each do |keyword|
        if @input.include?(keyword)
          moods << mood
          break
        end
      end
    end
    moods.empty? ? ["cozy"] : moods  # default to cozy if nothing detected
  end

  def matching_movies
    moods = detected_moods
    all_matches = Movie.all.select do |movie|
      tags = movie.mood_tags.split(",")
      (tags & moods).any?
    end

    # Score each movie by how many moods it matches
    scored = all_matches.map do |movie|
      tags = movie.mood_tags.split(",")
      score = (tags & moods).length
      { movie: movie, score: score }
    end

    scored.sort_by { |m| -m[:score] }.first(5).map { |m| m[:movie] }
  end
end