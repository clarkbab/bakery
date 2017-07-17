# frozen_string_literal: true

module Bakery
  ##
  # This class represents a line of an order.
  class Line
    attr_reader :code, :quantity

    ##
    # Creates a new line with +code+ and +quantity+.
    def initialize(args)
      @code = args[:code]
      @quantity = args[:quantity]
    end
  end
end
