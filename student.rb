require_relative './person'

class Student < Person
  attr_accessor :classroom

  def initialize(id, classroom, name: 'Unknown', age: 0, parent_permission: true)
    super(id, name: name, age: age, parent_permission: parent_permission)
    @classroom = classroom
    classroom.add_student(self)
  end

  def play_hooky
    '¯\(ツ)/¯'
  end
end
