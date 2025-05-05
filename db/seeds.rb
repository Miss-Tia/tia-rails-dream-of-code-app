require 'faker'

puts 'Seeding data...'

# Create coding classes
intro = CodingClass.find_or_create_by!(title: 'Intro to Programming',
                                       description: 'Learn the basics of web development, including HTML, CSS and Javascript.')
react = CodingClass.find_or_create_by!(title: 'React',
                                       description: 'Learn frontend web development with the React framework.')
node = CodingClass.find_or_create_by!(title: 'Node.js',
                                      description: 'Learn the basics of backend web development using Node.js.')
rails = CodingClass.find_or_create_by!(title: 'Ruby on Rails',
                                       description: 'Learn the basics of Ruby and the Ruby on Rails framework.')
python = CodingClass.find_or_create_by!(title: 'Python', description: 'Learn the basics of Python.')

# Create trimester records for 2023–2025
[
  %w[2023 Fall 2023-08-15 2023-09-01 2023-11-30],
  %w[2024 Spring 2024-02-15 2024-03-01 2024-05-31],
  %w[2024 Summer 2024-05-15 2024-06-01 2024-08-31],
  %w[2024 Fall 2024-08-15 2024-09-01 2024-11-30],
  %w[2025 Spring 2025-02-15 2025-03-05 2025-06-18],
  %w[2025 Summer 2025-06-15 2025-07-09 2025-10-24],
  %w[2025 Fall 2025-10-24 2025-11-12 2026-03-11]
].each do |year, term, deadline, start_date, end_date|
  Trimester.find_or_create_by!(
    year: year,
    term: term,
    application_deadline: deadline,
    start_date: start_date,
    end_date: end_date
  )
end

# Assign courses ONLY to Spring and Summer 2025
spring_2025 = Trimester.find_by(year: '2025', term: 'Spring')
summer_2025 = Trimester.find_by(year: '2025', term: 'Summer')

[spring_2025, summer_2025].each do |trimester|
  next unless trimester

  case trimester.term
  when 'Spring'
    [intro, react, node, rails, python].each do |klass|
      Course.find_or_create_by!(
        coding_class_id: klass.id,
        trimester_id: trimester.id,
        max_enrollment: 25
      )
    end
  when 'Summer'
    [intro, react, node].each do |klass|
      Course.find_or_create_by!(
        coding_class_id: klass.id,
        trimester_id: trimester.id,
        max_enrollment: 25
      )
    end
  end
end

# Create lessons for each course
Course.all.each do |course|
  (1..10).each do |lesson_number|
    Lesson.find_or_create_by!(
      course_id: course.id,
      title: "#{course.coding_class.title} - Week #{lesson_number}",
      lesson_number: lesson_number,
      assignment_due_date: course.trimester.start_date + (lesson_number * 9).days
    )
  end
end

# Enroll students in all Spring and Summer 2025 courses
Trimester.where(year: '2025', term: %w[Spring Summer]).each do |trimester|
  trimester.courses.each do |course|
    5.times do
      student = Student.find_or_create_by!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.unique.email
      )

      Enrollment.find_or_create_by!(
        course_id: course.id,
        student_id: student.id,
        final_grade: ['completed', nil].sample
      )
    end
  end
end

# Create mentors and mentor enrollment assignments
enrollment_count = Enrollment.count
mentor_count = (enrollment_count / 3.0).ceil

mentor_count.times do
  mentor = Mentor.find_or_create_by!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email
  )

  Enrollment.left_joins(:mentor_enrollment_assignments)
            .where(mentor_enrollment_assignments: { id: nil })
            .limit(3)
            .each do |enrollment|
    MentorEnrollmentAssignment.find_or_create_by!(
      mentor_id: mentor.id,
      enrollment_id: enrollment.id
    )
  end
end

puts '🌱 Seeding complete!'
