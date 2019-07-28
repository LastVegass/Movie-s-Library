require 'csv'
require 'ostruct'
require 'date'

def parse_txt_file(filename)
  name = filename.nil? ? 'movies.txt' : filename
  if name == 'movies.txt'
    CSV.read(name, col_sep: '|')
       .map { |m| create_movie(m) }
  else
    puts 'incorrect'
  end
end

def create_movie(movies)
  OpenStruct.new(
    link: movies[0],
    name: movies[1],
    year: movies[2],
    country: movies[3],
    release: turn_to_date(correct_date(movies[4])).mon,
    geners: movies[5],
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
  movies.select { |m| m[:geners].include?('Comedy') }
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
  "Title:#{m[:name]}, (#{m[:release]},#{m[:geners]} - #{m[:runtime]} "
end

def turn_to_date(release)
  Date.parse(release)
end

def correct_date(date_string)
  first_day = ('-01')
  if date_string.length == 7
    date_string + first_day
  elsif date_string.length == 4
    date_string + first_day + first_day
  elsif date_string.length == 10
    date_string
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

stats_year = {
  '1921' => [],
  '1925' => [],
  '1926' => [],
  '1927' => [],
  '1931' => [],
  '1934' => [],
  '1936' => [],
  '1939' => [],
  '1940' => [],
  '1941' => [],
  '1942' => [],
  '1944' => [],
  '1946' => [],
  '1948' => [],
  '1949' => [],
  '1950' => [],
  '1951' => [],
  '1952' => [],
  '1953' => [],
  '1954' => [],
  '1955' => [],
  '1956' => [],
  '1957' => [],
  '1958' => [],
  '1959' => [],
  '1960' => [],
  '1961' => [],
  '1962' => [],
  '1963' => [],
  '1964' => [],
  '1965' => [],
  '1966' => [],
  '1967' => [],
  '1968' => [],
  '1969' => [],
  '1971' => [],
  '1972' => [],
  '1973' => [],
  '1974' => [],
  '1975' => [],
  '1976' => [],
  '1977' => [],
  '1978' => [],
  '1979' => [],
  '1980' => [],
  '1981' => [],
  '1982' => [],
  '1983' => [],
  '1984' => [],
  '1985' => [],
  '1986' => [],
  '1987' => [],
  '1988' => [],
  '1989' => [],
  '1990' => [],
  '1991' => [],
  '1992' => [],
  '1993' => [],
  '1994' => [],
  '1995' => [],
  '1996' => [],
  '1997' => [],
  '1998' => [],
  '1999' => [],
  '2000' => [],
  '2001' => [],
  '2002' => [],
  '2003' => [],
  '2004' => [],
  '2005' => [],
  '2006' => [],
  '2007' => [],
  '2008' => [],
  '2009' => [],
  '2010' => [],
  '2011' => [],
  '2012' => [],
  '2013' => [],
  '2014' => [],
  '2015' => []
}

parse_txt_file(ARGV.first).map { |m| stats_year[m.year] << m }

puts stats_year['2010']
