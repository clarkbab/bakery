# frozen_string_literal: true

module Bakery
  ##
  # This class represents a solver that determines which orderable objects
  # to give to a customer.
  class LineSolver
    ##
    # Creates a new LineSolver with a +catalogue+.
    def initialize(args)
      @catalogue = args[:catalogue]
    end

    ##
    # This method returns the orderable objects for the customer given a +line+
    # of an order.
    def solve(line)
      # Get the desired amount.
      quantity = line.quantity

      # Search the catalogue for objects that match the line code.
      objects = @catalogue.search_by_code(line.code)

      # Sort the objects into largest first to minimise shipping size.
      objects.sort! { |a, b| b.quantity <=> a.quantity }

      # Solve the order.
      get_order(objects, quantity)
    end

    private

    ##
    # This method returns the total number of items in an +order+.
    def get_quantity(order)
      order.inject(0) { |total, object| total + object.quantity }
    end

    ##
    # This is a recursive method that takes an array of +objects+ and a desired
    # +quantity+. It returns the objects that satisy the order, or raises a
    # CantSatisyOrder exception if the order can't be completed.
    #
    # This method relies on +objects+ being sorted by descending quantity.
    #
    # Description of algorithm:
    #
    # This algorithm finds the first object that fits into the desired quantity
    # and adds it to the order. It then calculates the remaining quantity and
    # tries to recursively satisfy an order for that sub-quantity. It only
    # passes objects to the sub-method that are equal to or smaller than the
    # most recently added object. If the order can't be satisfied for a
    # quantity, it removes the last object and tries with the next largest
    # object. If it reaches the end of the objects array and none are small
    # enough to fit into the desired quantity, then it raises a CantSatisfyOrder
    # exception.
    def get_order(objects, quantity)
      order = []

      # Loop through all objects until one fits in the order.
      objects.each do |object|
        # Skip if the object can't be added to the order.
        next if object.quantity > quantity

        # Add the object to the order.
        order << object

        # Get remaining quantity.
        remaining_quantity = quantity - get_quantity(order)

        # Order has been fulfilled.
        return order if remaining_quantity.zero?

        # Get objects that have a size equal to, or smaller than, the added
        # object.
        possible_objects = objects.select do |item|
          item.quantity <= object.quantity
        end

        begin
          # Get objects which satisfy the remaining quantity.
          sub_order = get_order(possible_objects, remaining_quantity)

          # Add the solved sub-order to the main order.
          order.concat sub_order

          # Return the order.
          return order
        rescue Bakery::CantSatisfyOrder
          # Remove the object as we can't solve the order with it included.
          order.pop
        end
      end

      # None of the objects could fit into a successful order.
      raise Bakery::CantSatisfyOrder
    end
  end
end
