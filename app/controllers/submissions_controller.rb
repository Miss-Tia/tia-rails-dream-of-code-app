class SubmissionsController < ApplicationController
  before_action :require_student, only: %i[new create]
  before_action :require_mentor, only: %i[edit update]
  before_action :set_course, only: %i[new create]
  before_action :set_submission, only: %i[edit update]

  # GET /courses/:course_id/submissions/new
  def new
    @submission = Submission.new
    @lessons = @course.lessons
    @enrollments = @course.enrollments.includes(:student)
  end

  # POST /courses/:course_id/submissions
  def create
    @submission = Submission.new(submission_params)
    if @submission.save
      redirect_to root_path, notice: 'Submission successful.'
    else
      @lessons = @course.lessons
      @enrollments = @course.enrollments.includes(:student)
      flash.now[:alert] = 'Submission failed. Please check form for errors.'
      render :new, status: :unprocessable_entity
    end
  end

  # GET /submissions/1/edit
  def edit
  end

  # PATCH/PUT /submissions/1
  def update
    if @submission.update(submission_params)
      redirect_to root_path, notice: 'Submission update successful.'
    else
      flash.now[:alert] = 'Update failed. Please fix errors and try again.'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
    return if @course

    flash[:alert] = 'Course not found.'
    redirect_to root_path
  end

  def set_submission
    @submission = Submission.find_by(params[:id])
    return if @submission

    flash[:alert] = 'Submission not found.'
    redirect_to root_path
  end

  def submission_params
    params.require(:submission).permit(:enrollment_id, :lesson_id, :content, :url)
  end
end
