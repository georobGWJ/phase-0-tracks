# DBC GPS 2.2

# Method to create a hash
  # input: string of items separated by spaces (example: "carrots apples cereal pizza")
  # steps:
    # set default quantity
    # Create variable set to zero
    # Split each word into an index that creates an array
    # Turn indexes into keys
    # Set the values to our default variables, all start at zero


def create_hash(items)
  groceries = {}
  default_qty = 0
  items = items.split

  items.each do |food|
    groceries[food] = default_qty
  end
  
  groceries    
end


# Method to add an item to a list
# input: item name and optional quantity
# steps:
# output: Hash with items and values of zero
def add_item(groceries, food, qty = 0)
  groceries[food] = qty
end


# Method to remove an item from the list
# input: item name
# steps:
  # Use delete method to remove item from hash
# output: Hash
def remove_item(groceries, food)
  groceries.delete(food)
end

# Method to update the quantity of an item
# input: Item we want to replace and the new quantity
# steps:
  # Set new value to new input key
# output: Hash
def update_qty(groceries, food, qty)
  groceries[food] = qty
end


# Method to print a list and make it look pretty
# input: Hash Name
# steps:
 # Iterate through the list to print out each item and quantity
# output:
def pretty_print(groceries)
  groceries.each do |key, value|
    puts "You have #{value} #{key}(s)."
  end
end


foods = create_hash('apple carrot cheese')
p foods
updated_foods = add_item(foods, 'pizza', 3)
p foods
remove_item(foods, 'carrot')
p foods
update_qty(foods, 'cheese', 20)
p foods

pretty_print(foods)