require_relative './person'

class Teacher < Person
  def initialize(specialization, name: 'Unknown', age: 0, parent_permission: true)
    super(name: name, age: age, parent_permission: parent_permission)
    @specialization = specialization
  end

  def to_json(*args)
    super.merge(
      'specialization' => @specialization
    ).to_json(*args)
  end

  def can_use_services?
    true
  end
end
