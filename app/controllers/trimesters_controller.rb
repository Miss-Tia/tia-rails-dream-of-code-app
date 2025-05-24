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
    return head :bad_request if params[:trimester].nil?

    deadline = params[:trimester][:application_deadline]

    if deadline.present?
      begin
        parsed_date = Date.parse(deadline)
      rescue ArgumentError
        return head :bad_request
      end
      @trimester.application_deadline = parsed_date
    end

    if @trimester.update(trimester_params)
      redirect_to @trimester, notice: 'Trimester updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_trimester
    @trimester = Trimester.find_by(id: params[:id])
    head :not_found unless @trimester
  end

  def trimester_params
    params.require(:trimester).permit(:application_deadline)
  end
end
