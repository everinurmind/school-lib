require_relative './person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, name = 'Unknown', parent_permission: true)
    super(age: age, name: name, parent_permission: parent_permission)
  end
end
