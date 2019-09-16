require 'csv'
require 'ostruct'
require 'date'
require_relative 'movie'
require_relative 'movie_collection'

def parse_txt_file(filename)
  name = filename.nil? ? 'movies.txt' : filename
  if name == 'movies.txt'
    CSV.read(name, col_sep: '|')
       .map { |m| create_movie(m) }
  else
    []
  end
end

def create_movie(movies)
  OpenStruct.new(
    link: movies[0],
    name: movies[1],
    year: movies[2],
    country: movies[3],
    release: correct_date(movies[4]),
    genre: movies[5],
    runtime: movies[6],
    rate: rating_to_stars(movies[7].to_f),
    director: movies[8],
    actors: movies[9]
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
  movies.select { |m| m[:genre].include?('Comedy') }
        .sort_by { |m| m[:release] }
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
  "Title:#{m[:name]}, (#{m[:release]},#{m[:genre]}) - #{m[:runtime]} "
end

def correct_date(date)
  case date.split('-').length
  when 1
    Date.parse(date + '-01-01')
  when 2
    Date.parse(date + '-01')
  when 3
    Date.parse(date)
  end
end

MONS = {
  1 => 'January',
  2 => 'February',
  3 => 'March',
  4 => 'April',
  5 => 'May',
  6 => 'June',
  7 => 'July',
  8 => 'August',
  9 => 'September',
  10 => 'October',
  11 => 'November',
  12 => 'December'
}.freeze

stats = {
  'January' => [],
  'February' => [],
  'March' => [],
  'April' => [],
  'May' => [],
  'June' => [],
  'July' => [],
  'August' => [],
  'September' => [],
  'October' => [],
  'November' => [],
  'December' => []
}

def year_list(years)
  years.map { |m| m[:genre] }
       .sort
       .uniq
end

def year_list(years)
  list = years.map { |m| m[:year] }
              .sort
              .uniq
  Hash[list.collect { |item| [item, []] }]
end

x = Movie_colletion.new('movies.txt')

puts x.stats(actors: "Brad Pitt")
