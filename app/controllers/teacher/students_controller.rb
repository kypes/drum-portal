module Teacher
  class StudentsController < BaseController
    def index
      @students = User.student.includes(:assigned_lessons)
    end

    def show
      @student = User.student.find(params[:id])
      @lessons = @student.assigned_lessons.includes(:teacher).recent_first
    end
  end
end 