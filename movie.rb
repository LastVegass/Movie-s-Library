class Movie
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

  def link(m)
    m = @link
  end

  def name(m)
    m = @name
  end

  def year(m)
    m = @year
  end

  def country(m)
    m = @country
  end

  def release(m)
    m = @release
  end

  def genre(m)
    m = @genre
  end

  def runtime
    @runtime
  end

  def rate
    @rate
  end

  def director
    @director
  end

  def actors
    @actors
  end

  def set(field, value)
    send("#{field}",value)
  end

end
