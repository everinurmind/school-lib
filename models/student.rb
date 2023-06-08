require_relative './person'

class Student < Person
  attr_accessor :classroom, :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    super(age: age, name: name, parent_permission: parent_permission)
  end

  def to_json(*args)
    {
      'id' => @id,
      'name' => @name,
      'age' => @age,
      'rentals' => @rentals,
      'classroom' => @classroom
    }.to_json(*args)
  end
end
