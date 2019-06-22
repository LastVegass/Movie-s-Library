def parse_txt_file(file_name)
file_name.nil? ? 'movies.txt' : file_name
  if file_name == 'movies.txt'
    File.read(file_name)
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

def movie_with_USA_date(movies)
  movies.select { |m| m[:country].include? 'USA' }
  movies.select { |m| m[:year].include? '1995' }
end

def rating_to_stars(rating)
  '*' * ((rating - 8.0) * 10.0).round
end

puts movie_with_USA_date(parse_txt_file(ARGV.first))
