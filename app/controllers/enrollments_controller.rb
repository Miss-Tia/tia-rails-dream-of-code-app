class EnrollmentsController < ApplicationController
  before_action :set_enrollment, only: %i[show edit update destroy]
  before_action :require_admin, only: %i[index show new create edit update destroy]
  # GET /enrollments or /enrollments.json
  def index
    @enrollments = Enrollment.all
  end

  # GET /enrollments/1 or /enrollments/1.json
  def show
  end

  # GET /enrollments/new
  def new
    @course = Course.find(params[:course_id])
    @enrollment = @course.enrollments.build
    @students = Student.all
  end

  # GET /enrollments/1/edit
  def edit
  end

  # POST /enrollments or /enrollments.json
  def create
    @course = Course.find(params[:course_id])
    @enrollment = @course.enrollments.build(enrollment_params)

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to course_path(@course), notice: 'Student enrolled successfully.' }
        format.json { render :show, status: :created, location: @enrollment }
      else
        @students = Student.all
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /enrollments/1 or /enrollments/1.json
  def update
    respond_to do |format|
      if @enrollment.update(enrollment_params)
        format.html { redirect_to @enrollment, notice: 'Enrollment was successfully updated.' }
        format.json { render :show, status: :ok, location: @enrollment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @enrollment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /enrollments/1 or /enrollments/1.json
  def destroy
    @enrollment.destroy!

    respond_to do |format|
      format.html { redirect_to enrollments_path, status: :see_other, notice: 'Enrollment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_enrollment
    @enrollment = Enrollment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def enrollment_params
    params.require(:enrollment).permit(:course_id, :student_id, :final_grade)
  end
end
