class TrimestersController < ApplicationController
  before_action :set_trimester, only: %i[show edit update]

  def index
    @trimesters = Trimester.all
  end

  def show
  end

  def edit
    # Renders the edit form
  end

  def update
    if @trimester.update(trimester_params)
      redirect_to @trimester, notice: 'Trimester updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_trimester
    @trimester = Trimester.find(params[:id])
  end

  def trimester_params
    params.require(:trimester).permit(:application_deadline)
  end
end
