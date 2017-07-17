# frozen_string_literal: true

module Bakery
  ##
  # This class represents a parser for clients' orders.
  class OrderParser
    ##
    # This is the regular expression used for matching an order line.
    LINE_REGEXP = /(\d+)\s+(\w+)/

    ##
    # This method takes the +filepath+ of a valid order. The order is parsed and
    # Line objects are returned.
    #
    # This method raises an InvalidFilePath exception if the file specified
    # doesn't exist.
    def parse(filepath)
      raise Bakery::InvalidFilepath unless File.exist?(filepath)

      # Parse the lines of the file.
      File.open(filepath).map do |line|
        parse_line(line)
      end
    end

    private

    ##
    # This method parses a line of the text file and returns a Line object.
    #
    # This method raises an InvalidOrderFormat if the order line format isn't
    # valid.
    def parse_line(line)
      # Match the text line with the expected format.
      matches = Regexp.new(LINE_REGEXP).match(line)

      raise InvalidOrderFormat unless matches

      # Create the line from the order.
      Line.new(code: matches[2], quantity: matches[1].to_i)
    end
  end
end
