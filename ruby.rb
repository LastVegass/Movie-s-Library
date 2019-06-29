def parse_txt_file(filename)
mass = filename.nil? ? 'movies.txt' : filename
  if mass == 'movies.txt'
      File.read(mass)
        .split("\n")
        .map { |a| a.split('|') }
        .map { |m| create_movie(m) }
  	 else
      	puts 'incorrect'
    end
end

def create_movie(movies)
  {
    link: movies[0],
    name: movies[1],
    year: movies[2],
    country: movies[3],
    realise: movies[4],
    geners: movies[5],
    runtime: movies[6],
    rate: rating_to_stars(movies[7].to_f),
    director: movies[8],
    stars: movies[9]
  }
end

def movie_with_max_in_name(movies)
  movies.select { |m| m[:name].include? 'Max' }
end

def movie_with_usa_date(movies)
  movies.select { |m| m[:year].include?('1995') && m[:country].include?('USA') }
end

def rating_to_stars(rating)
  '*' * ((rating - 8.0) * 10.0).round
end

def movie_size(movies)
  size = movies.map { |m| m[:name].length  }
  rightsize = size.sort.reverse
  movies.select { |m| m[:name].length > rightsize[5]}
end

def movie_comedy(movies)
  comedy = movies.select { |m| m[:geners].include? ('Comedy') }
  comedyrealise = comedy.map { |m| m[:realise].to_i }
  rightdate = comedyrealise.sort
  movies.select { |m| m[:realise].to_i < rightdate[10] && m[:geners].include?('Comedy') }
end

def movie_directors_list(movies)
  movies.map(&:sort).flatten {|m| m[:director]}
end

puts movie_size(parse_txt_file(ARGV.first))
