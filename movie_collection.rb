require 'csv'
require_relative 'movie'
require_relative 'movie_collection'
class Movie_colletion
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
      righ_list_of_keys = stats_arguments.values.concat(['all'])
      arguments_hash_list = Hash[righ_list_of_keys.collect { |item| [item, []] }]
      first_argument_value = arguments_hash_list.keys[0]
      second_argument_value = arguments_hash_list.keys[1]
      first_argument_key = stats_arguments.keys[0]
      second_argument_key = stats_arguments.keys[1]
      first_argument_film_list = @collection.select { |z| z.send(first_argument_key).include?(first_argument_value) }
      second_argument_film_list= @collection.select { |z| z.send(second_argument_key).include?(second_argument_value) }
      arguments_hash_list.keys.map do |key|
        if first_argument_value.include?(key)
          arguments_hash_list[key] << first_argument_film_list.length
        elsif second_argument_value.include?(key)
          arguments_hash_list[key] << second_argument_film_list.length
        else
        arguments_hash_list[key] << first_argument_film_list.length + second_argument_film_list.length
        end
      end
      puts arguments_hash_list.keys.map { |e| @collection.select { |z| z.send(e).include?}  }
      arguments_hash_list
    end
end

x = Movie_colletion.new('movies.txt')

puts x.stats(genre: 'Comedy', actors: 'Brad Pitt')
