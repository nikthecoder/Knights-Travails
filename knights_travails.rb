require 'thread'

class ChessKnight
  def initialize(parent, position)
    @position = position
    @children = []
    @parent = parent
    generate_moves
  end

  def generate_moves
    (0...8).each do |i|
      (0...8).each do |j|
        @children << [i, j] if (knight_valid_move?(@position, i, j) && valid_position?([i, j]))
      end
    end
  end

  def get_moves
    @children
  end

  def get_position
    @position
  end

  def get_parent
    @parent
  end

  private

  def knight_valid_move?(start_position, new_x, new_y)
    ((new_x - start_position[0]).abs == 1) && ((new_y - start_position[1]).abs == 2) ||
      ((new_x - start_position[0]).abs == 2) && ((new_y - start_position[1]).abs == 1)
  end

  def valid_position?(end_position)
    (end_position[0].between?(0, 7) && end_position[1].between?(0, 7))
  end
end

def find_shortest_path(start_position, end_position)
  queue = Queue.new
  initial_node = ChessKnight.new(nil, start_position)
  queue << initial_node
  path = []

  until queue.empty?
    current_node = queue.pop

    if current_node.get_position == end_position
      loop do
        path << current_node.get_position
        break if current_node.get_parent.nil?

        current_node = current_node.get_parent
      end

      return path.reverse
    end

    current_node.get_moves.each do |move|
      queue << ChessKnight.new(current_node, move)
    end
  end

  nil
end

def print_path(path)
  puts "\nYou made it in #{path.length - 1} moves! Here's your path:"
  path.each do |position|
    puts position.to_s
  end
end

path = find_shortest_path([3, 3], [4, 3])
print_path(path)
