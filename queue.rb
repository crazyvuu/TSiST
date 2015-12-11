class Person
  def initialize(name, age, incoming_race)
    @name = name
    @age = age
    self.race = incoming_race
  end

  def nam
    @name.split.map(&:capitalize).join(" ")
  end

  def agE
    @age
  end

  def method_missing(m, *args)
    if m == :race
      @race.capitalize
    elsif m == :name
      @name.split.map(&:capitalize).join(' ')
    elsif m == :age
      @age
    elsif m == :race=
      @race = args[0]
    else
      super
    end
  end
end

person = Person.new("kurt vonnegut", 89, "caucasian")
puts person.name
puts person.race
puts person.age