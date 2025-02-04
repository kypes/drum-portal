module Student
  class CommentsController < BaseController
    before_action :set_lesson

    def create
      @comment = @lesson.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        respond_to do |format|
          format.html { redirect_to [ :student, @lesson ], notice: "Comment was successfully added." }
          format.turbo_stream
        end
      else
        redirect_to [ :student, @lesson ], alert: "Error adding comment."
      end
    end

    private

    def set_lesson
      @lesson = current_user.assigned_lessons.find(params[:lesson_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
  end
end
