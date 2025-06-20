class AdminDashboardController < ApplicationController
  def index
    @current_trimester = Trimester
                         .includes(courses: :coding_class)
                         .where('start_date <= ?', Date.today)
                         .where('end_date >= ?', Date.today)
                         .first

    @upcoming_trimester = Trimester
                          .includes(courses: :coding_class)
                          .where('start_date > ?', Date.today)
                          .order(:start_date)
                          .first

    puts "Today is: #{Date.today}"
    puts "Current Trimester: #{@current_trimester.inspect}"
    puts "Upcoming Trimester: #{@upcoming_trimester.inspect}"
  end
end
