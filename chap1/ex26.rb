#!/usr/bin/env ruby

#module Cartesian

class Point
  attr_reader :x, :y

  def initialize(x, y)
    @x = Integer(x)
    @y = Integer(y)
  end

  def distance_to(point)
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
  attr_accessor :distance_travelled
  def initialize
    @distance_travelled = 0
  end

end

class NeighborHeuristic<Heuristic
  def find_next(points)
    min = 99999999
    minPoint = nil
    points.each do |point|
      distance = @current_point.distance_to(point)
      if (min == nil) || (distance < min)
        min = distance 
        minPoint = point
        #puts "new Minpoint: #{minPoint}"
      end
    end
    minPoint
  end

  def run(points)
    puts "NeighborHeuristic"
    #@current_point = points.shift
    self.current_point = points.shift
    puts "Current point is: #{@current_point}"
    while !points.empty?
      nxt = self.find_next(points)
      @distance_travelled += self.current_point.distance_to(nxt)
      self.current_point = nxt
      puts "Next: #{nxt}"
      points.delete nxt
    end
    puts "Done!"
  end
end

#Heuristic 2
#Closest Pair
class PairHeuristic<Heuristic
  def run(points)
    #puts "PairHeuristic"
    self.current_point = points.shift
    while !points.empty?
      d = 99999999
      minPair = [ ]

      s, t = nil
      #for each pair of endpoints (s, t) from distinct vertex chains
      0.upto(points.length - 1) do |i|
        s = points[i]
        0.upto(points.length - 1) do |j|
          t = points[j]
          if (s.distance_to(t) < d)
            d = s.distance_to(t)
            minPair = [s, t]
          end
        end
      end

      #connect sm, tm by an edge
      self.distance_travelled += current_point.distance_to s
      self.distance_travelled += s.distance_to t
      self.current_point = t

      points.delete s
      points.delete t
    end
    #connect two endpoints by an edge

  end
end

#Execution

def TrackTime(cls, points)
  startTime = Time.new
  heur = cls.new
  heur.run(points.dup)
  endTime = Time.new
  delta = endTime - startTime
  puts "#{cls.to_s} elapsed time: #{delta}"
  delta
end

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

heuristics = [PairHeuristic, NeighborHeuristic]

min = 999999999
minHeuristic = nil
heuristics.each do |heuristic|
  time = TrackTime(heuristic, @@data)
  puts "TrackTime result: #{time}"
  #time = min if (time < min)
  if (time < min)
    min = time
    minHeuristic = heuristic
  end
  puts ""
end

puts "Min time: #{min}"
puts "Min heuristic: #{minHeuristic}"
