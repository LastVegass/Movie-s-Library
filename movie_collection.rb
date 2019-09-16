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

  def stats(film)
    list = film.reduce(@collection) { |filtered, (key, value)| filtered.select { |m| m.send(key).include?(value) } }
    list_1 = film.reduce(@collection) { |filter, (key, value)| filter.map { |e| e.send(key) } }
                 .join(',')
                 .split(',')
                 .sort
                 .uniq
    list_hash = Hash[list_1.collect { |item| [item, []] }]
    list_hash.keys.map { |key| if key.include?(film.values.first)
                                 list_hash[key] << list
                               end
                       }
    list_hash
  end
end
