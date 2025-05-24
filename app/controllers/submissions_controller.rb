class SubmissionsController < ApplicationController
  # GET /submissions/new
  def new
    @course = Course.find(params[:course_id])
    @submission = Submission.new
    @lessons = @course.lessons
    @students = Student.all
  end

  # POST /courses/:course_id/submissions
  def create
    @course = Course.find(params[:course_id])
    @submission = Submission.new(submission_params)
    @submission.course = @course

    if @submission.save
      redirect_to course_path(@course), notice: 'Submission was successfully created.'
    else
      @lessons = @course.lessons
      @students = Student.all
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
    params.require(:submission).permit(:lesson_id, :student_id, :mentor_id, :content, :reviewed_at)
  end
end
