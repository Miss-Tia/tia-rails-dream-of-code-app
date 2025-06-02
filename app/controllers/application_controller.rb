class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end

  # Role-based access control

  def require_admin
    puts "require_admin triggered for user: #{current_user&.username} (#{current_user&.role})"
    return if current_user&.role == 'admin'

    flash[:alert] = 'You do not have access to that page.'
    redirect_to root_path
  end

  def require_mentor
    return if current_user&.role == 'mentor'

    flash[:alert] = 'You do not have access to that page.'
    redirect_to root_path
  end

  def require_student
    return if current_user&.role == 'student'

    flash[:alert] = 'You do not have access to that page.'
    redirect_to root_path
  end
end
