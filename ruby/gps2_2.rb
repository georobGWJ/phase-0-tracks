# DBC GPS 2.2

# Method to create a hash
  # input: string of items separated by spaces (example: "carrots apples cereal pizza")
  # steps:
    # set default quantity
    # Create variable set to zero
    # Split each word into an index that creates an array
    # Turn indexes into keys
    # Set the values to our default variables, all start at zero

# Method to add an item to a list
# input: item name and optional quantity
# steps:
# output: Hash with items and values of zero

# Method to remove an item from the list
# input: item name
# steps:
  # Use delete method to remove item from hash
# output: Hash

# Method to update the quantity of an item
# input: Item we want to replace and the new quantity
# steps:
  # Set new value to new input key
# output: Hash

# Method to print a list and make it look pretty
# input: Hash Name
# steps:
  # Iterate through the list to print out each item and quantity
# output:

def create_hash(items, default_qty = 0)
  groceries = {}
  items.split.each { |food| groceries[food] = default_qty }
  groceries    
end

def add_item(groceries, food, qty = 0)
  groceries[food] = qty
end

def remove_item(groceries, food)
  groceries.delete(food)
end

def update_qty(groceries, food, qty)
  add_item(groceries, food, qty)
end

def pretty_print(groceries)
  groceries.each { |food, qty| puts "You have #{qty} #{food}(s)." }
end


# foods = create_hash('apple carrot cheese')
# p foods
# updated_foods = add_item(foods, 'pizza', 3)
# p foods
# remove_item(foods, 'carrot')
# p foods
# update_qty(foods, 'cheese', 20)
# p foods

# pretty_print(foods)