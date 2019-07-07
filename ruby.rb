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
    realise: movies[4].to_i,
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
  rightsize = movies.map { |m| m[:name].length }
                    .sort
                    .reverse
  movies.select { |m| m[:name].length > rightsize[5] }
end

def movies_comedy(movies)
  rightdate = movies.select { |m| m[:geners].include?('Comedy') }
                    .map { |m| m[:realise] }
                    .sort
  movies.select { |m| m[:realise] < rightdate[10] && m[:geners].include?('Comedy') }
end

def movie_directors_list(movies)
  movies.map { |m| m[:director] }
        .map { |m| m.split(' ') }
        .map(&:last)
        .sort
        .uniq
end

def movies_not_usa(movies)
  movies.select do |m|
    unless m[:country].include?('USA')
      puts "#{m[:name]} (#{m[:realise]} ; #{m[:geners]}) - #{m[:runtime]} "
    end
  end
end

puts movie_size(parse_txt_file(ARGV.first))
