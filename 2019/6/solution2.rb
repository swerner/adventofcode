require "pry"
class Planet
  attr_reader :name, :in_orbit_around, :orbiters

  def initialize(name)
    @name = name
    @in_orbit_around = nil
    @orbiters = []
  end

  def add_orbit(other_planet)
    @in_orbit_around = other_planet
  end

  def add_orbiter(other_planet)
    @orbiters << other_planet
  end

  def orbit_count
    return 0 if name == "COM"
    1 + @in_orbit_around.orbit_count
  end

  def orbiters_contain(planet)
    @orbiters.any? { |orbiter| orbiter.name == planet || orbiter.orbiters_contain(planet) }
  end

  def distance_from(planet)
    return 0 if planet == name
    return nil unless orbiters_contain(planet)
    return 1 + orbiters.map{ |orbiter| orbiter.distance_from(planet) }.compact.min
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
      @planets[parent].add_orbiter(@planets[child])
    end
  end

  def checksum
    @planets.reject{ |k, v| k == "COM"}.values.sum(&:orbit_count)
  end

  def paths_between(start_planet, end_planet)
    distance = 0
    planet = @planets[start_planet]


    while !planet.orbiters_contain(end_planet)
      planet = planet.in_orbit_around
      distance = distance + 1

      if planet.name == "COM"
        binding.pry
      end
    end

    distance = distance + planet.distance_from(end_planet) - 2
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
# K)L
# K)YOU
# I)SAN")
orbits = Orbits.new(File.open("input.txt").read)

puts orbits.paths_between("YOU", "SAN")
