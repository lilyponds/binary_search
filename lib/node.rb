class Node
  def initialize(value = nil, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end

  attr_accessor :value, :left, :right

  def data
    @value
  end

  def leaf?
    return true if @left.nil? && @right.nil?

    false
  end

  def single_child?
    if @left.nil? && @right.nil?
      false
    elsif @left.nil? || @right.nil?
      true
    else
      false
    end
  end

  def delete_node
    @value = nil
    @left = nil
    @right = nil
  end
end
