require 'rest-client'
require 'json'
require 'pry'


movies = []

def get_hash
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)
  return response_hash
  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
end


def get_movie(response_hash, character_name)
  all_characters = response_hash["results"]
  all_characters.each do |char|
    if char["name"] == character_name
      return char["films"].sort
    end
  end
  abort("This name is not part of the SWAPi. Thanks, have a great day :)")

  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
  
end


def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  #get_character_movies_from_api("Luke Skywalker")["results"][0]["films"][0]
  films.each do |movie_link|
    response_title_raw = RestClient.get(movie_link)
    response_title_hash = JSON.parse(response_title_raw) 
    puts response_title_hash["title"]
  end
end


def show_character_movies(response_hash, character)
  films = get_movie(response_hash, character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?

