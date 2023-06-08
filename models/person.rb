require_relative '../helpers/nameable'
require_relative './rental'

class Person < Nameable
  attr_accessor :name, :age, :rentals
  attr_reader :id

  def initialize(name: 'Unknown', age: 0, parent_permission: true)
    super()
    @id = Random.rand(1..255)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def id=(new_id)
    @id = new_id
  end

  def to_json(*args)
    {
      'id' => @id,
      'name' => @name,
      'age' => @age,
      'rentals' => @rentals
    }.to_json(*args)
  end

  def add_rental(book, date)
    rental = Rental.new(date, book, self)
    @rentals << rental
  end

  def correct_name
    @name
  end

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end
