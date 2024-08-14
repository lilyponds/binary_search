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

      else
        # How to deal with tree deletion

      end
    else
      puts 'Value does not exist in tree.'
    end
    pretty_print
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
