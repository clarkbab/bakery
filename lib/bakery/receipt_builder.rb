# frozen_string_literal: true

module Bakery
  ##
  # This class represents a builder of order receipts for customers.
  class ReceiptBuilder
    ##
    # This is the format string used for building the summary line.
    SUMMARY_LINE_FORMAT = '%d %s $%.2f'

    ##
    # This is the format string used for building the item line.
    ITEM_LINE_FORMAT = '  %d x %d $%.2f'

    ##
    # This method builds an array of text strings for printing onto the
    # receipt. It accepts an array of orderable +objects+.
    #
    # This method raises a InconsistentCode exception if the +objects+ don't
    # have the same code.
    def build_line(objects)
      # This raises an exception unless all objects have the same code.
      raise Bakery::InconsistentCodes unless identical_codes?(objects)

      # Add summary line to response.
      response = [summary_text(objects)]

      # Separate the objects into groups by their quantity.
      groups = group_by_quantity(objects)

      # Add the text for each group.
      groups.each do |group|
        response << group_text(group)
      end

      response
    end

    ##
    # This method returns the message to be printed when an order line
    # could not be fulfilled.
    def error_line
      'Your order could not be fulfilled.'
    end

    private

    ##
    # This method determines if all the orderable +objects+ passed have the same
    # code.
    def identical_codes?(objects)
      objects.map(&:code).uniq.count == 1
    end

    ##
    # This method builds the summary for an array of +objects+.
    def summary_text(objects)
      format(
        SUMMARY_LINE_FORMAT,
        total_quantity(objects),
        objects.first.code,
        total_price(objects)
      )
    end

    ##
    # This method builds the text for a +group+ of objects.
    def group_text(group)
      format(
        ITEM_LINE_FORMAT,
        group.count,
        group.first.quantity,
        group.first.price
      )
    end

    ##
    # This method returns the total quantity in all the orderable +objects+.
    def total_quantity(objects)
      objects.inject(0) { |total, object| total + object.quantity }
    end

    ##
    # This method returns the total price of all the orderable +objects+.
    def total_price(objects)
      objects.inject(0) { |total, object| total + object.price }
    end

    ##
    # This methods separates +objects+ into groups of differing quantities.
    def group_by_quantity(objects)
      groups = []

      objects.each do |object|
        # Has object already been added to a group?
        next if groups.flatten.include?(object)

        # Get quantity.
        quantity = object.quantity

        # Get all objects with this quantity.
        group = objects.select { |obj| obj.quantity == quantity }

        groups << group
      end

      groups
    end
  end
end
