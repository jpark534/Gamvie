movies = [
  { title: "Eternal Sunshine of the Spotless Mind", genre: "Drama/Romance", mood_tags: "heartbreak,sad,love,loss", description: "A couple erases each other from their memories after a painful breakup.", poster_url: "", rating: 8.3 },
  { title: "The Secret Life of Walter Mitty", genre: "Adventure/Drama", mood_tags: "lost,hopeful,adventure,motivation", description: "A daydreamer embarks on an unexpected journey of self-discovery.", poster_url: "", rating: 7.3 },
  { title: "Interstellar", genre: "Sci-Fi", mood_tags: "wonder,existential,epic,deep", description: "Astronauts travel through a wormhole in search of a new home for humanity.", poster_url: "", rating: 8.6 },
  { title: "Soul", genre: "Animation/Drama", mood_tags: "existential,hopeful,lost,meaning", description: "A musician discovers what it truly means to have a soul.", poster_url: "", rating: 8.1 },
  { title: "Superbad", genre: "Comedy", mood_tags: "happy,funny,bored,social", description: "Two best friends try to make the most of their last days of high school.", poster_url: "", rating: 7.6 },
  { title: "La La Land", genre: "Musical/Romance", mood_tags: "heartbreak,love,nostalgic,bittersweet", description: "A jazz musician and an actress fall in love while chasing their dreams.", poster_url: "", rating: 8.0 },
  { title: "The Social Network", genre: "Drama", mood_tags: "motivated,ambitious,focused,studying", description: "The story of how Facebook was founded.", poster_url: "", rating: 7.8 },
  { title: "Spirited Away", genre: "Animation/Fantasy", mood_tags: "wonder,escape,anxious,cozy", description: "A young girl wanders into a world of spirits and must find her way back.", poster_url: "", rating: 8.6 },
  { title: "Good Will Hunting", genre: "Drama", mood_tags: "lost,heartbreak,motivated,deep", description: "A janitor with a gift for mathematics resists the opportunities available to him.", poster_url: "", rating: 8.3 },
  { title: "The Grand Budapest Hotel", genre: "Comedy/Adventure", mood_tags: "bored,funny,quirky,cozy", description: "A legendary concierge and his protégé become embroiled in a murder mystery.", poster_url: "", rating: 8.1 },
  { title: "Her", genre: "Sci-Fi/Romance", mood_tags: "lonely,love,existential,heartbreak", description: "A man falls in love with an AI operating system.", poster_url: "", rating: 8.0 },
  { title: "Whiplash", genre: "Drama/Music", mood_tags: "motivated,ambitious,stressed,focused", description: "A music student pushes his limits under an abusive instructor.", poster_url: "", rating: 8.5 },
  { title: "Everything Everywhere All at Once", genre: "Sci-Fi/Comedy", mood_tags: "overwhelmed,existential,funny,family", description: "A woman discovers she must connect with parallel universe versions of herself.", poster_url: "", rating: 7.8 },
  { title: "Princess Mononoke", genre: "Animation/Fantasy", mood_tags: "epic,adventure,angry,wonder", description: "A prince becomes embroiled in a struggle between forest gods and humans.", poster_url: "", rating: 8.4 },
  { title: "About Time", genre: "Romance/Drama", mood_tags: "heartbreak,love,cozy,hopeful,family", description: "A man with the ability to time travel tries to find love and happiness.", poster_url: "", rating: 7.8 },
  { title: "Mad Max: Fury Road", genre: "Action", mood_tags: "angry,adventure,dark,intense", description: "A woman rebels against a tyrannical ruler in a post-apocalyptic wasteland.", poster_url: "", rating: 8.1 },
  { title: "John Wick", genre: "Action/Thriller", mood_tags: "angry,dark,revenge,intense", description: "An ex-hitman comes out of retirement to track down the gangsters who killed his dog.", poster_url: "", rating: 7.4 },
  { title: "Inside Out", genre: "Animation/Drama", mood_tags: "sad,family,nostalgic,hopeful,funny", description: "A young girl's emotions come to life as she navigates a big life change.", poster_url: "", rating: 8.1 },
  { title: "The Notebook", genre: "Romance/Drama", mood_tags: "romantic,heartbreak,love,nostalgic", description: "A poor young man and a rich young woman fall in love during the 1940s.", poster_url: "", rating: 7.8 },
  { title: "Parasite", genre: "Thriller/Drama", mood_tags: "dark,angry,existential,intense", description: "A poor family schemes to become employed by a wealthy family.", poster_url: "", rating: 8.5 },
  { title: "The Dark Knight", genre: "Action/Thriller", mood_tags: "dark,angry,intense,existential", description: "Batman faces the Joker, a criminal mastermind who wants to plunge Gotham into anarchy.", poster_url: "", rating: 9.0 },
  { title: "Clueless", genre: "Comedy/Romance", mood_tags: "happy,funny,romantic,bored", description: "A rich high schooler tries to boost a new student's popularity.", poster_url: "", rating: 6.9 },
  { title: "Chef", genre: "Comedy/Drama", mood_tags: "hopeful,motivated,funny,family", description: "A chef who loses his restaurant job starts a food truck with his son.", poster_url: "", rating: 7.3 },
]

movies.each do |movie|
  Movie.find_or_create_by(title: movie[:title]) do |m|
    m.genre = movie[:genre]
    m.mood_tags = movie[:mood_tags]
    m.description = movie[:description]
    m.poster_url = movie[:poster_url]
    m.rating = movie[:rating]
  end
end

puts "#{Movie.count} movies seeded!"