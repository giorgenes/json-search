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
    @index.bsearch_index do |i|
      value = @data_accessor.call(i)

      value >= query
    end
  end
end