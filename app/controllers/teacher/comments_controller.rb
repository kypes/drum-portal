module Teacher
  class CommentsController < BaseController
    before_action :set_lesson
    before_action :set_comment, only: [:destroy]

    def create
      @comment = @lesson.comments.build(comment_params)
      @comment.user = current_user

      if @comment.save
        respond_to do |format|
          format.html { redirect_to [:teacher, @lesson], notice: 'Comment was successfully added.' }
          format.turbo_stream
        end
      else
        redirect_to [:teacher, @lesson], alert: 'Error adding comment.'
      end
    end

    def destroy
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to [:teacher, @lesson], notice: 'Comment was successfully deleted.' }
        format.turbo_stream
      end
    end

    private

    def set_lesson
      @lesson = current_user.taught_lessons.find(params[:lesson_id])
    end

    def set_comment
      @comment = @lesson.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
  end
end 