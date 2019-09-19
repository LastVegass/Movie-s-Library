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
    #list_right_films = film.reduce(@collection) { |filtered, (key, value)| filtered.select { |m| m.send(key).include?(value) } }
    list_main = film.keys.map { |e| @collection.map { |z| z.send(e) } }
                    .join(',')
                    .split(',')
                    .sort
                    .uniq
    list_hash = Hash[list_main.collect { |item| [item, []] }]
    list_hash.keys.map { |key| if film.values.include?(key)
                                 list_hash[key] << film.reduce(@collection) { |filtered, (key, value)| filtered.select { |m| m.send(key).include?(value) } }
                               end
    }
    list_hash
  end
end
