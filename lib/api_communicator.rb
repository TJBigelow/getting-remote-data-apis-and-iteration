require 'rest-client'
require 'json'
require 'pry'

def search_result(character_name)
  response_string = RestClient.get("http://swapi.dev/api/people/?search=#{character_name}")
  hash = JSON.parse(response_string)
  hash['results'][0] ? hash['results'][0] : (raise NonexistentCharacterError)
end

def searched_character_name(character_name)
  search_result(character_name)['name']
end

def get_character_movies_from_api(character_name)
  character_result = search_result(character_name)
  character_films = character_result['films']
  film_apis = map_apis(character_films)
  film_apis.map{|api| JSON.parse(api)}
end

def map_apis(apis)
  apis.map{|api_link| RestClient.get(api_link)}
end

def print_movies(films)
  films.map {|film| "#{films.index(film) +1}. #{film['title']}"}
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  puts "#{searched_character_name(character)} is in:"
  puts print_movies(films)
end


## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
