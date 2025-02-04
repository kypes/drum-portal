module Teacher
  class LessonsController < BaseController
    before_action :set_lesson, only: [:show, :edit, :update, :destroy]

    def index
      @lessons = current_user.taught_lessons.includes(:assigned_to).recent_first
    end

    def show
      @comments = @lesson.comments.includes(:user).recent_first
    end

    def new
      @lesson = current_user.taught_lessons.build
      @students = User.where(role: :student)
    end

    def create
      @lesson = current_user.taught_lessons.build(lesson_params)
      
      if @lesson.save
        respond_to do |format|
          format.html { redirect_to [:teacher, @lesson], notice: 'Lesson was successfully created.' }
          format.turbo_stream
        end
      else
        @students = User.where(role: :student)
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @students = User.where(role: :student)
    end

    def update
      if @lesson.update(lesson_params)
        redirect_to [:teacher, @lesson], notice: 'Lesson was successfully updated.'
      else
        @students = User.where(role: :student)
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @lesson.destroy
      respond_to do |format|
        format.html { redirect_to teacher_lessons_path, notice: 'Lesson was successfully deleted.' }
        format.turbo_stream
      end
    end

    private

    def set_lesson
      @lesson = current_user.taught_lessons.find(params[:id])
    end

    def lesson_params
      params.require(:lesson).permit(:title, :content, :assigned_to_id, :youtube_url)
    end
  end
end 