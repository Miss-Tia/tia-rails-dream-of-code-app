class Api::V1::EnrollmentsController < ApplicationController
  def index
    course = Course.find(params[:course_id])
    enrollments = course.enrollments.includes(:student)

    enrollment_data = enrollments.map do |enrollment|
      {
        id: enrollment.id,
        student_name: "#{enrollment.student.first_name} #{enrollment.student.last_name}",
        student_email: enrollment.student.email,
        enrolled_at: enrollment.created_at.strftime('%Y-%m-%d')
      }
    end

    render json: { enrollments: enrollment_data }, status: :ok
  end
end
