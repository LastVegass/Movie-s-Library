class Movie_colletion
  def initialize(collection)
    @collection = collection
  end

  def all
    @collection
  end

  def sort_by(i)
      @collection.send((@collection.map { |m| m.set(i,m) }), (@collection.map { |m| m }) )
    end

  def set(field, value)
    send("#{field}", value)
  end

end
