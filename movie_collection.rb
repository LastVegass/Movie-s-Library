require 'csv'
require_relative 'movie'

class MovieColletion
  def initialize(text_file)
    @collection = parse_txt_file(text_file)
  end

  def parse_txt_file(filename)
    name = filename.nil? ? 'movies.txt' : filename
    if name == 'movies.txt'
      CSV.read(name, col_sep: '|')
         .map { |m| Movie.new(m) }
    else
      []
    end
  end

  def all
    @collection
  end

  def sort_by(film)
    @collection.select { |m| m.send(film) }
               .sort_by { |m| m.send(film) }
  end

  def filter(filters)
    filters.reduce(@collection) { |filtered, (key, value)| filtered.select { |m| m.send(key).include?(value)}  }
  end

    def stats(stats_arguments)
      arguments_hash_list = Hash[stats_arguments.values.collect { |item| [item, nil] }]
      stats_arguments.map { |key, value| arguments_hash_list[value] = @collection.select { |movie| movie.send(key).include?(value)}.length }
      arguments_hash_list["all"] = arguments_hash_list.values.inject { |sum, n| sum + n }
      arguments_hash_list
    end
end

x = MovieColletion.new('movies.txt')

puts x.stats(genre: 'Comedy', actors: 'Brad Pitt')
