#!/usr/bin/env ruby

#module Cartesian

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = Integer(x)
    @y = Integer(y)
  end

  def get_distance(point)
    Math.sqrt(
      (x - point.x) ** 2 +
      (y - point.y) ** 2
    )
  end

  def to_s
    "(#{x}, #{y})"
  end
end
#end


#Heuristic 1

#Nearest Neighbor
class Heuristic
  attr_accessor :current_point
  attr_reader :distance_traveled
  def initialize
    @distance_traveled = 0
  end

  def find_next(points)
    min = 999999
    minPoint = nil
    points.each do |point|
      distance = @current_point.get_distance(point)
      if (min == nil) || (distance < min)
        min = distance 
        minPoint = point
        #puts "new Minpoint: #{minPoint}"
      end
    end
    minPoint
  end

  def run(points)
    #@current_point = points.shift
    self.current_point = points.shift
    puts "Current point is: #{@current_point}"
    while !points.empty?
      nxt = self.find_next(points)
      @distance_traveled += self.current_point.get_distance(nxt)
      self.current_point = nxt
      puts "Next: #{nxt}"
      points.delete nxt
    end
    puts "Done!"
    puts "Distance travelled: #{@distance_traveled}"
  end
end

class NeighborHeuristic<Heuristic

  def find_next(points)
    min = 999999
    minPoint = nil
    points.each do |point|
      distance = @current_point.get_distance(point)
      if (min == nil) || (distance < min)
        min = distance 
        minPoint = point
        #puts "new Minpoint: #{minPoint}"
      end
    end
    minPoint
  end
end

#Heuristic 2
#Closest Pair

#Main
@@data = [ ]

ARGV.each do |arg|
    f = File.open(arg, "r") 
    f.each_line do |line|
      #Dataset
      splits = line.split(',')
      #@@data.push line
      @@data.push Point.new(splits[0], splits[1])
      #puts splits
    end

    @@data.each do |item|
      #puts item
    end
end

heur = Heuristic.new
heur.run(@@data)
