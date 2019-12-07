require "pry"
class Planet
  attr_reader :name, :in_orbit_around

  def initialize(name)
    @name = name
    @in_orbit_around = nil
  end

  def add_orbit(other_planet)
    @in_orbit_around = other_planet
  end

  def orbit_count
    return 0 if name == "COM"
    1 + @in_orbit_around.orbit_count
  end

  def inspect
    name
  end
end

class Orbits
  def initialize(map)
    @planets = {}
    process_map(map)
  end

  def process_map(map)
    map_by_orbits = map.split("\n")

    map_by_orbits.each do |orbit|
      parent, child = orbit.split(")")

      if !@planets[parent]
        @planets[parent] = Planet.new(parent)
      end

      if !@planets[child]
        @planets[child] = Planet.new(child)
      end

      @planets[child].add_orbit(@planets[parent])
    end
  end

  def checksum
    @planets.reject{ |k, v| k == "COM"}.values.sum(&:orbit_count)
  end
end

# orbits = Orbits.new("COM)B
# B)C
# C)D
# D)E
# E)F
# B)G
# G)H
# D)I
# E)J
# J)K
# K)L")

orbits = Orbits.new(File.open("input.txt").read)

puts orbits.checksum
