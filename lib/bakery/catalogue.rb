# frozen_string_literal: true

module Bakery
  ##
  # This class represents a catalogue of items.
  class Catalogue
    ##
    # Creates a new catalogue with +items+.
    def initialize(args)
      @items = args[:items]
    end

    ##
    # This method searches the catalogue for all items with a matchine +code+.
    def search_by_code(code)
      @items.select { |item| item.code == code }
    end
  end
end
