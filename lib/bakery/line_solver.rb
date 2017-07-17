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
      ordered_quantity = line.quantity

      # Search the catalogue for objects that match the line code.
      objects = @catalogue.search_by_code(line.code)

      # Sort the objects into largest first to minimise shipping size.
      objects.sort! { |a, b| b.quantity <=> a.quantity }

      # Solve the order.
      get_order(objects, ordered_quantity)
    end

    private

    ##
    # This method returns the total quantity of items in an +order+.
    def get_total_quantity(order)
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
    # tries to recursively satisfy an order for that sub-quantity. If the order
    # can't be satisfied for that quantity, it removes the object and tries with
    # the next largest object. If it reaches the end of the objects array and
    # none fit into the desired quantity, then it raises a CantSatisfyOrder
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
        remaining_quantity = quantity - get_total_quantity(order)

        # Order has been fulfilled.
        return order if remaining_quantity.zero?

        begin
          # Get objects which satisfy the remaining quantity.
          order << get_order(objects, remaining_quantity)

          # Flatten the order array to combine the sub-order with this order.
          order.flatten!

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
