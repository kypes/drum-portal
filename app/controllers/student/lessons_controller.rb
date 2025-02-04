module Student
  class LessonsController < BaseController
    before_action :set_lesson, only: [:show, :mark_as_viewed]

    def index
      @lessons = current_user.assigned_lessons.includes(:teacher).recent_first
      @points = current_user.points
    end

    def show
      @comments = @lesson.comments.includes(:user).recent_first
      @comment = Comment.new
    end

    def mark_as_viewed
      @lesson.mark_as_viewed_by(current_user)
      respond_to do |format|
        format.html { redirect_to [:student, @lesson], notice: 'Lesson marked as viewed.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace('points', partial: 'shared/points', locals: { points: current_user.points }) }
      end
    end

    private

    def set_lesson
      @lesson = current_user.assigned_lessons.find(params[:id])
    end
  end
end 