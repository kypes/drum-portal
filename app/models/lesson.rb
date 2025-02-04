class Lesson < ApplicationRecord
  # Associations
  belongs_to :teacher, class_name: "User"
  belongs_to :assigned_to, class_name: "User"
  has_many :comments, dependent: :destroy

  # Validations
  validates :title, presence: true
  validates :content, presence: true
  validate :teacher_must_be_teacher
  validate :assigned_to_must_be_student

  # Callbacks
  after_create :send_notification_email
  after_create :increment_student_points

  # Scopes
  scope :by_teacher, ->(teacher_id) { where(teacher_id: teacher_id) }
  scope :for_student, ->(student_id) { where(assigned_to_id: student_id) }
  scope :recent_first, -> { order(created_at: :desc) }

  # Methods
  def mark_as_viewed_by(user)
    return unless user == assigned_to
    increment_student_points
  end

  private

  def teacher_must_be_teacher
    return if teacher&.teacher?
    errors.add(:teacher, "must be a teacher")
  end

  def assigned_to_must_be_student
    return if assigned_to&.student?
    errors.add(:assigned_to, "must be a student")
  end

  def send_notification_email
    LessonMailer.with(lesson: self).new_lesson_notification.deliver_later
  end

  def increment_student_points
    assigned_to.increment_points!(5) # 5 points for viewing a lesson
  end
end
