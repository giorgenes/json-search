describe Index do
  let(:data) { ['B', 'A', 'C'] }
  let(:data_accessor) { ->(i) { data[i] } }
  let(:index) { Index.new(data.size, data_accessor) }

  describe '#initialize' do
    it 'creates an index based on the provided data' do
      expect(index.instance_variable_get(:@index)).to eq([1, 0, 2])
    end
  end

  describe '#[]' do
    it 'returns the index of the element at the given position' do
      expect(index[0]).to eq(1)
      expect(index[1]).to eq(0)
      expect(index[2]).to eq(2)
    end
  end

  describe '#term' do
    it 'returns the index of the first element greater than or equal to the query' do
      expect(index.term('A')).to eq(0)
      expect(index.term('B')).to eq(1)
      expect(index.term('C')).to eq(2)
      expect(index.term('D')).to be_nil
    end
  end
end