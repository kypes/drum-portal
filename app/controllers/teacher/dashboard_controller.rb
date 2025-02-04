module Teacher
  class DashboardController < BaseController
    def index
      @lessons = current_user.taught_lessons.includes(:assigned_to).recent_first
      @students = User.where(role: :student)
    end
  end
end 