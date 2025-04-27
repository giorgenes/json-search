class Index
  def initialize(size, data_accessor)
    @size = size
    @index = (0...size).to_a
    @data_accessor = data_accessor

    @index.sort_by! do |i|
      @data_accessor.call(i)
    end
  end

  def [](i)
    @index[i]
  end

  def term(query)
    loc = @index.bsearch_index do |i|
      value = @data_accessor.call(i)

      value >= query
    end

    return nil if loc.nil?

    @data_accessor.call(@index[loc]) == query ? loc : nil
  end

  def prefix(query)
    loc = @index.bsearch_index do |i|
      value = @data_accessor.call(i)

      value[0, query.length] >= query
    end

    return [] if loc.nil?

    matches = []

    while loc < @size
      value = @data_accessor.call(@index[loc])
      if value[0, query.length] == query
        matches << @index[loc]
      else
        break
      end

      loc += 1
    end

    matches
  end
end