class Api::V1::EnrollmentsController < ApplicationController
  def index
    course = Course.find(params[:course_id])
    enrollments = course.enrollments.includes(:student)

    enrollment_data = enrollments.map do |enrollment|
      {
        id: enrollment.id,
        studentId: enrollment.student.id,
        studentFirstName: enrollment.student.first_name,
        studentLastName: enrollment.student.last_name,
        finalGrade: enrollment.final_grade || ''
      }
    end

    render json: { enrollments: enrollment_data }, status: :ok
  end
end
