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
    list = @collection.map { |m| m.send(film) }
                      .sort
                      .uniq
    list_hash = Hash[list.collect { |item| [item, []] }]
    @collection.map { |e| list_hash[e.send(film)] << e }
    puts list_hash
  end
end
