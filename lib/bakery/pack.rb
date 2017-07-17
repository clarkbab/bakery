# frozen_string_literal: true

module Bakery
  ##
  # This class represents a pack of baked goods.
  class Pack
    attr_reader :code, :price, :quantity

    ##
    # Creates a new pack with +code+, +price+ and +quantity+.
    def initialize(args)
      @code = args[:code]
      @price = args[:price]
      @quantity = args[:quantity]
    end
  end
end
