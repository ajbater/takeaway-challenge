require_relative 'menu.rb'

class Takeaway

  attr_reader :menu, :items

  def initialize
    @menu = Menu.new
    @items = {}
  end

  def show_menu
    menu.show_menu
  end

  def add_item(item, quantity = 1)
    # raise 'This item is not on the menu, please choose something else' if !Menu::MENU.has_key?(item)
    raise 'Quantity must be more than 0' if quantity <= 0
    if @items.has_key?(item)
      @items[item] += quantity
    else
      @items[item] = quantity
    end
  end

end