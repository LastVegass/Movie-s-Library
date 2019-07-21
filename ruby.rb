require 'csv'
require 'ostruct'

def parse_txt_file(filename)
  mass = filename.nil? ? 'movies.txt' : filename
  if mass == 'movies.txt'
    CSV.read(mass, col_sep: '|')
       .map { |m| create_movie(m) }
  else
    puts 'incorrect'
  end
end

def create_movie(movies)
  OpenStruct.new(:link => movies[0],
    :name => movies[1],
    :year => movies[2],
    :country => movies[3],
    :realise => movies[4],
    :geners => movies[5],
    :runtime => movies[6],
    :rate => rating_to_stars(movies[7].to_f),
    :director => movies[8],
    :stars => movies[9]
  )
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
  movies.map { |m| m[:name] }
        .sort_by(&:length).reverse
        .take(5)
end

def movie_comedy(movies)
  movies.select { |m| m[:geners].include?('Comedy') }
        .sort_by { |m| m[:realise] }
        .take(10)
end

def movie_directors_list(movies)
  movies.map { |m| m[:director].split(' ').last }
        .sort
        .uniq
end

def movies_not_usa(movies)
  movies.reject { |m| m[:country].include?('USA') }
end

def pretty_print(m)
  "Title:#{m[:name]}, (#{m[:realise]},#{m[:geners]} - #{m[:runtime]} "
end

puts parse_txt_file(ARGV.first)
