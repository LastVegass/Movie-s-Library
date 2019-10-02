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
    right_films = stats_arguments.reduce(@collection) { |filtered, (key, value)| filtered.select { |m| m.send(key).include?(value) } }
    argument_stats_collection = stats_arguments.keys.map { |stats_key| @collection.map { |movie| movie.send(stats_key)  } }
                                                                                  .join(',')
                                                                                  .split(',')
                                                                                  .sort
                                                                                  .uniq
    arguments_hash_list = Hash[argument_stats_collection.collect { |item| [item, []] }]
    arguments_hash_list.keys.map do |key|
      if stats_arguments.values.include?(key)
        arguments_hash_list[key] << right_films
      end
    end
    #stats_arguments.reduce(@collection) { |filtered, (key, value)| filtered.select { |m| m.send(key).include?(value) } }
    #puts arguments_hash_list.reduce(@collection) { |filter, (key,value)| filter.select { } }
    #  if stats_arguments.values.include?(key)
    #    arguments_hash_list[key] << right_films
    #  end
    #end
    arguments_hash_list
  end
end
