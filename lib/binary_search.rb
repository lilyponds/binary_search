# frozen_string_literal: true

require_relative './merge_sort'
require_relative './node'

class Tree
  def initialize(unsorted_arr)
    @arr = merge_sort(unsorted_arr).uniq
    @root = build_tree(@arr)
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
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
