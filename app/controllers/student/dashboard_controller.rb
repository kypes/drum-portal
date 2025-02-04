module Student
  class DashboardController < BaseController
    before_action :ensure_student

    def index
      @lessons = current_user.assigned_lessons.includes(:teacher).recent_first
      @points = current_user.points
    end

    private

    def ensure_student
      unless current_user.student?
        redirect_to root_path, alert: 'Access denied. Students only.'
      end
    end
  end
end 