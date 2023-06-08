require_relative './person'

class Student < Person
  attr_accessor :classroom

  def initialize(age, name = 'Unknown', parent_permission: true)
    super(age: age, name: name, parent_permission: parent_permission)
  end

  def to_json(*args)
    super.merge(
      'classroom' => @classroom
    ).to_json(*args)
  end
end
