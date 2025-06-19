class Api::V1::CoursesController < ApplicationController
  def index
    current_trimester = Trimester.current
    courses = current_trimester ? current_trimester.courses : []

    courses_array = courses.map do |course|
      {
        id: course.id,
        title: course.coding_class.title,
        application_deadline: course.trimester.application_deadline.to_s,
        start_date: course.trimester.start_date.to_s,
        end_date: course.trimester.end_date.to_s
      }
    end

    render json: { courses: courses_array }, status: :ok
  end
end
