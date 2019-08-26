class Movie
  attr_reader :link, :name, :year, :country, :release, :genre, :runtime, :rate, :director, :actors
  def initialize(link, name, year, country, release, genre, runtime, rate, director, actors)
    @link = link
    @name = name
    @year = year
    @country = country
    @release = release
    @genre = genre
    @runtime = runtime
    @rate = rate
    @director = director
    @actors = actors
  end

  def to_s
    "Link: #{@link} // #{@name} - #{@year} - #{@country} -(#{@release}) -
    #{@genre} - (#{@runtime}) - #{@rate} - #{@director} - #{@actors}"
  end

  def set(field, value)
    send("#{field}",value)
  end

end
