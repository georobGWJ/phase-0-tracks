# I worked with Meredith Jones, github ID: meredith-jones for Challenge 6.5
# on 8 September 13:00 PDT

class TodoList

  attr_accessor :list

  def initialize(array = [])
    @list = array
  end

  def add_item(item)
    @list << item
  end

  def delete_item(item)
    @list.delete(item)
  end

  def get_items()
    @list
  end
  
  def get_item(index)
    @list[index]
  end
end
