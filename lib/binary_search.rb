# frozen_string_literal: true

require_relative './merge_sort'
require_relative './node'

class Tree
  def initialize(unsorted_arr)
    @arr = merge_sort(unsorted_arr).uniq
    @root = build_tree(@arr)
    @items_order = []
  end

  def build_tree(array)
    length = array.length
    root = nil
    if length > 1
      root_index = (length / 2).floor
      root_value = array[root_index]
      left = array[0...root_index]
      right = array[(root_index + 1)...length]
      root = Node.new(root_value, build_tree(left), build_tree(right))
    elsif length == 1
      root = Node.new(array[0])
    end
    root
  end

  def insert(value)
    insert_recursion(value)
    pretty_print
  end

  # this is the method that actually does the insertion
  # the method above simnply calls it and prints the new tree
  def insert_recursion(value, root = @root)
    return unless value != root.value

    if root.value > value
      if root.left.nil?
        root.left = Node.new(value)
      else
        insert_recursion(value, root.left)
      end
    elsif root.value < value
      if root.right.nil?
        root.right = Node.new(value)
      else
        insert_recursion(value, root.right)
      end
    end
  end

  def delete(value)
    node = find(value)
    # puts find_parent(value)
    # puts find_parent(value).value
    # puts node
    # puts node.value
    if !node.nil?
      if node.leaf?
        if find_parent(value).value > value
          find_parent(value).left = nil
        else
          find_parent(value).right = nil
        end

      elsif node.single_child?
        if find_parent(value).value > value
          find_parent(value).left = if !node.right.nil?
                                      node.right
                                    else
                                      node.left
                                    end
        else
          find_parent(value).right = if !node.right.nil?
                                       node.right
                                     else
                                       node.left
                                     end
        end

      elsif !node.leaf? && !node.single_child?
        # Look to the right of the value, and then go the
        # furthest left possible and replace with that value
        if node.right.leaf?
          node.value = node.right.value
          node.right = nil
        elsif node.right.single_child?
          if !node.right.left.nil?
            node.value = node.right.left.value
            node.right.left = nil
          else
            node.value = node.right.value
            node.right.value = node.right.right.value
            node.right.right = nil
          end
        else
          smallest_node_on_right = smallest_node_on_a_subtree(node.right)
          node.value = smallest_node_on_right.value
          smallest_node_on_right.delete_node
        end
      end
    else
      puts 'Value does not exist in tree.'
    end
    clean_up
    pretty_print
  end

  # method for deletion when the element
  # being removed has a complete subtree
  def smallest_node_on_a_subtree(root)
    return root if root.left.nil?

    smallest_node_on_a_subtree(root.left)
  end

  def find(value, root = @root)
    return nil if root.nil?

    if root.value == value
      root
    elsif root.value > value
      find(value, root.left)
    else
      find(value, root.right)
    end
  end

  def pre_order_logic(root = @root)
    return if root.nil?

    @items_order.push(root.value)
    pre_order_logic(root.left)
    pre_order_logic(root.right)
  end

  def in_order_logic(root = @root)
    return if root.nil?

    in_order_logic(root.left)
    @items_order.push(root.value)
    in_order_logic(root.right)
  end

  def post_order_logic(root = @root)
    return if root.nil?

    post_order_logic(root.left)
    post_order_logic(root.right)
    @items_order.push(root.value)
  end

  def level_order_logic(root = @root)
    return if root.nil?

    temp_arr = []
    @items_order.push(root)
    until @items_order.empty?
      temp_arr.push(@items_order[0].value)
      @items_order.push(root.left) unless root.left.nil?
      @items_order.push(root.right) unless root.right.nil?
      @items_order.shift
      root = @items_order[0]
    end
    temp_arr
  end

  def all_order
    clean_up
    pre_order_logic
    p @items_order
    @items_order = []
    in_order_logic
    p @items_order
    @items_order = []
    post_order_logic
    p @items_order
    @items_order = []
    p level_order_logic
    @items_order = []
  end

  def height(root = @root)
  end

  def find_parent(value, root = @root)
    # return nil if root.left.nil? && root.right.nil?
    return 'This is root of the tree.' if root.value == value

    if !root.right.nil? && root.right.value == value
      root
    elsif !root.left.nil? && root.left.value == value
      root
    elsif !root.value.nil?
      if root.value > value
        find_parent(value, root.left)
      else
        find_parent(value, root.right)
      end
    end
  end

  def rebalance
    initialize(level_order_logic)
    pretty_print
  end

  # a method to clean up all the addresses leading to nil nodes
  def clean_up(root = @root)
    return if root.right.nil? && root.left.nil?

    root.right = nil if !root.right.nil? && root.right.value.nil?
    root.left = nil if !root.left.nil? && root.left.value.nil?
    clean_up(root.left) unless root.left.nil?
    clean_up(root.right) unless root.right.nil?
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
