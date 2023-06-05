class PersonCreator
  def initialize(library)
    @library = library
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    choice = gets.chomp
    if choice == '1'
      create_student_from_input
    elsif choice == '2'
      create_teacher_from_input
    else
      puts 'Invalid choice'
    end
  end

  def create_student_from_input
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp.downcase == 'y'
    @library.create_student(age, name, permission)
    puts 'Person created successfully'
  end

  def create_teacher_from_input
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    @library.create_teacher(age, name, specialization)
    puts 'Person created successfully'
  end
end
