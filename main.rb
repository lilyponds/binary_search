# frozen_string_literal: true

require './lib/binary_search'

# test = Tree.new(Array.new(15) { rand(1..100) })
test = Tree.new((1..15).to_a)
test.pretty_print
puts '--------------'
test.insert(99)
puts '--------------'
puts test.find(99)
puts test.find(81)
puts '--------------'
test.delete(15)
test.delete(99)
test.delete(14)
puts '--------------'
test.delete(10)
puts '--------------'
test.delete(13)
puts '--------------'
test.delete(12)
puts '--------------'
test.delete(8)
