class LessonMailer < ApplicationMailer
  def new_lesson_notification
    @lesson = params[:lesson]
    @student = @lesson.assigned_to
    @teacher = @lesson.teacher

    mail(
      to: @student.email,
      subject: "New Lesson: #{@lesson.title}"
    )
  end
end
