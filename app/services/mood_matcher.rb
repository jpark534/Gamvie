class MoodMatcher
  MOOD_KEYWORDS = {
    "heartbreak"  => ["rejected", "breakup", "broke up", "heartbroken", "miss her", "miss him", "dumped", "lonely", "alone", "she left", "he left", "can't get over", "moved on", "ex", "unrequited", "ghosted", "ghosting"],
    "sad"         => ["sad", "crying", "depressed", "unhappy", "miserable", "devastated", "hurt", "tearful", "grief", "grieving", "loss", "upset", "down", "blue", "gloomy", "hopeless", "empty", "numb", "broken"],
    "angry"       => ["mad", "angry", "furious", "rage", "pissed", "annoyed", "frustrated", "irritated", "livid", "fed up", "hate", "heated", "fuming", "resentful", "bitter", "outraged", "infuriated"],
    "happy"       => ["happy", "great", "amazing", "excited", "celebrate", "celebration", "good mood", "joyful", "elated", "thrilled", "ecstatic", "pumped", "over the moon", "fantastic", "wonderful", "delighted", "cheerful", "content"],
    "motivated"   => ["motivated", "grind", "hustle", "working hard", "ambitious", "goal", "productive", "driven", "determined", "focused", "inspired", "grinding", "self improvement", "level up", "discipline", "succeed"],
    "bored"       => ["bored", "nothing to do", "boring", "tired", "meh", "whatever", "dull", "restless", "aimless", "killing time", "procrastinating", "unmotivated", "sluggish", "blah"],
    "anxious"     => ["anxious", "nervous", "stressed", "overwhelmed", "panic", "worried", "anxiety", "tense", "on edge", "uneasy", "scared", "fear", "dread", "overthinking", "spiraling", "can't sleep", "insecure"],
    "hopeful"     => ["hopeful", "better", "optimistic", "looking up", "new start", "fresh", "turning around", "things are looking", "bright side", "positive", "encouraged", "looking forward"],
    "existential" => ["meaning", "purpose", "why", "life", "exist", "universe", "deep thoughts", "what's the point", "who am i", "identity", "philosophy", "consciousness", "reality", "searching", "lost myself"],
    "cozy"        => ["cozy", "rainy", "blanket", "tea", "coffee", "chill", "relax", "lazy", "background", "curl up", "quiet night", "stay in", "comfy", "warm", "slow day", "peaceful", "gentle"],
    "adventure"   => ["adventure", "travel", "explore", "outdoors", "something new", "road trip", "spontaneous", "wild", "thrill", "adrenaline", "escape", "journey", "wander"],
    "wonder"      => ["wonder", "inspired", "beautiful", "mind blown", "interstellar", "space", "universe", "awe", "breathtaking", "magnificent", "surreal", "spectacular", "wow"],
    "funny"       => ["funny", "laugh", "comedy", "humor", "fun", "lol", "hilarious", "crack up", "lighthearted", "silly", "goofy", "witty", "cheer me up", "need a laugh", "make me laugh"],
    "nostalgic"   => ["nostalgic", "childhood", "memories", "old times", "remember when", "throwback", "miss those days", "back then", "simpler times", "reminisce", "growing up"],
    "focused"     => ["studying", "study", "focus", "concentrate", "work", "background noise", "exam", "homework", "assignment", "library", "late night", "pulling an all nighter"],
    "lost"        => ["lost", "confused", "direction", "don't know", "unsure", "what to do", "no idea", "at a crossroads", "stuck", "drifting", "quarter life", "life crisis", "figuring out"],
    "romantic"    => ["date night", "anniversary", "love", "romantic", "crush", "falling for", "butterflies", "flirting", "relationship", "partner", "together", "in love", "valentine"],
    "dark"        => ["dark", "twisted", "disturbing", "intense", "thriller", "creepy", "unsettling", "sinister", "macabre", "noir", "gritty", "raw", "haunting"],
    "family"      => ["family", "kids", "parents", "siblings", "home", "together", "relatives", "reunion", "wholesome", "all ages", "children", "mom", "dad"]
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