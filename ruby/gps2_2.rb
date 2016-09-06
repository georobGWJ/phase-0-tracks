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

# Reflection
# ==========
# What did you learn about pseudocode from working on this challenge?
#--------------------------------------------------------------------
# I learned that while pseudocoding is very valuable in structuring your
# logic prior to writing actual code, that it doesn't set that logic
# in stone. Once you begin coding, it may be necessary to deviate from the
# pseudocode that you have written.


# What are the tradeoffs of using arrays and hashes for this challenge?
#----------------------------------------------------------------------
# The structure of hashes fits the structure of the data being stored and 
# allows for more intuitive labels. For example with this hash:
# food = {'bean' => 4, 'soda' => 6}
# It is easy to remember that if you want to know how many beans you have
# to call food['bean']

# An alternative could have been using an array of arrays. For example:
# food = [ ['bean', 4], ['soda', 6] ]
# This is more difficult to work with, to get the number of beans you
# have, you'd need to remember that value is at food[0][1] or by
# looping through the array to find beans.


# What does a method return?
#---------------------------

# By default, a method will return the value of the last line of code that it
# runs. You can set an explicit Return statement if you want something else
# returned.

# What kind of things can you pass into methods as arguments?
#------------------------------------------------------------

# You can pass any object as an argument, Fixnums, Strings, arrays, instances
# of classes, and so on. You can also pass objects with attached methods
# such as words.split if the method is expecting an array. I'm guessing that's
# bad form though.


# How can you pass information between methods?
#----------------------------------------------

# If one method (method_A) needs data from another method (method_B), then
# you can ensure that method_B returns that data and pass method_B as 
# an argument into method_A.


# What concepts were solidified in this challenge, and what
# concepts are still confusing?
#----------------------------------------------------------

# I got a better understanding of passing information between methods and
# more practice working with hashes. It was also satisfying to pseudocode
# with my pair. I'm not confused by any of the concepts but do recognize
# that I should keep practicing with them.