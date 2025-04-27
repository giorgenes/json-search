require 'json'
require 'uri'
require 'open-uri'

class JsonAdapter
  attr_reader :docs

  def initialize
    @docs = []
  end

  def load_from(uri)
    URI.open(uri) do |file|
      file_content = file.read
      @docs = JSON.parse(file_content)
    end
  rescue OpenURI::HTTPError => e
  end

end