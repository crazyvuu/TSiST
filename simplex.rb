require 'matrix'

class Simplex
  def initialize(conditions, goal, free_elems)
    @table = conditions
    @old_table = conditions
    @goal = goal
    @free_elems = free_elems
  end

  def table
    @table
  end

  def old_table
    @old_table
  end

  def goal
    @goal
  end

  def free_elems
    @free_elems
  end

  def key_elem
    @key_elem
  end

  def key_elem_coords
    @key_elem_coords
  end

  def set_key_elem
    negative_elem = @goal.find { |elem| elem < 0 }
    key_column_index = @goal.find_index(negative_elem)
    key_column = @table.map { |row| row[key_column_index] }
    i = 0
    ratio_array = []
    @free_elems.each do |elem|
      ratio_array[i] = elem / key_column[i]
      i+=1
    end
    key_row_index = ratio_array.find_index(ratio_array.min)
    @key_elem = @table[key_column_index][key_row_index]
    @key_elem_coords = [key_column_index, key_row_index]
  end

  def jordan_conversion
    i = 0
    new_table=[[0, 0], [0, 0]]
    @table.each do |row|
      j = 0
      if (i == @key_elem_coords[0])
        row.each do |elem|
          if (j == @key_elem_coords[1])
            new_table[i][j] = 1/@key_elem
          else
            new_table[i][j] = elem/@key_elem
          end
          j+=1
        end
      else
        row.each do |elem|
          if (j == @key_elem_coords[1])
            new_table[i][j] = -elem/@key_elem
          else
            new_table[i][j] = (elem*@key_elem - @table[@key_elem_coords[0]][j]*@table[i][@key_elem_coords[1]])/@key_elem
          end
          j+=1
        end
      end
      i+=1
    end
    self.goal_conversion
    @table = new_table
  end

  def goal_conversion
    i = 0
    @goal.each do |elem|
      if (i != @key_elem_coords[1])
        @goal[i] = (elem*@key_elem - @table[@key_elem_coords[0]][i]*@goal[@key_elem_coords[0]])/@key_elem
      end
      i+=1
    end
    @goal[@key_elem_coords[1]] = -@goal[@key_elem_coords[1]]/@key_elem
  end
end

y1 = [2.0, 1.0, 17.0]
y2 = [5.0, 4.0, 49.0]
goal = [-23.0, -18.0, 0.0]
free_elems = [y1[y1.length - 1], y2[y2.length - 1]]
simplex = Simplex.new([y1, y2], goal, free_elems)
steps = 0
while (simplex.goal.any? { |n| n < 0 })
  simplex.set_key_elem
  simplex.jordan_conversion
  steps += 1
end
puts "steps count - " + steps.to_s
simplex.table.each do |row|
  puts row.inspect
end
puts simplex.goal.inspect