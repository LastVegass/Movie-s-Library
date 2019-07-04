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
  movies.select { |m| m[:name].include?('Max') }
end

def movie_with_usa_date(movies)
  movies.select { |m| m[:year].include?('1995') && m[:country].include?('USA') }
end

def rating_to_stars(rating)
  '*' * ((rating - 8.0) * 10.0).round
end

def movie_size(movies)
  movies.map { |m| m[:name].length }
        .sort.reverse
        .select { |m| m[:name].length > rightsize[5] }
end

def movie_comedy(movies)
  movies.select { |m| m[:geners].include?('Comedy') }
        .map { |m| m[:realise].to_i }
        .sort
        .select { |m| m[:realise].to_i < rightdate[10] && m[:geners].include?('Comedy') }
end

def movie_directors_list(movies)
  movies.map { |m| m[:director] }
        .sort
        .uniq
        .map { |m| m.split(' ') }
        .map(&:last)
end

def movies_not_usa(movies)
  movies.select do |m|
    unless m[:country].include?('USA')
      puts m[:name], m[:realise], m[:geners], m[:runtime], m[:stars].chomp!
    end
  end
end

puts movies_not_usa(parse_txt_file(ARGV.first))
