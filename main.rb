# frozen_string_literal: true

require './lib/binary_search'

test = Tree.new(Array.new(15) { rand(1..100) })
test.pretty_print
puts '--------------'
test.insert(99)
