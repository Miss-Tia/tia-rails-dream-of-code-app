class SubmissionsController < ApplicationController
  # GET /courses/:course_id/submissions/new
  def new
    @course = Course.find(params[:course_id])
    @submission = Submission.new
    @lessons = @course.lessons
    @enrollments = @course.enrollments.includes(:student)
  end

  # POST /courses/:course_id/submissions
  def create
    @course = Course.find(params[:course_id])
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to course_path(@course), notice: 'Submission was successfully created.'
    else
      @lessons = @course.lessons
      @enrollments = @course.enrollments.includes(:student)
      render :new, status: :unprocessable_entity
    end
  end

  # GET /submissions/1/edit
  def edit
    # TBD
  end

  # PATCH/PUT /submissions/1
  def update
    # TBD
  end

  private

  def submission_params
    params.require(:submission).permit(:enrollment_id, :lesson_id, :content, :url)
  end
end
