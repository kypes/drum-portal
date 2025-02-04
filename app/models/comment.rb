class Comment < ApplicationRecord
  # Constants
  POINTS_FOR_COMMENT = 5

  # Associations
  belongs_to :user
  belongs_to :lesson

  # Validations
  validates :content, presence: true
  validates :user, presence: true
  validates :lesson, presence: true

  validate :user_can_comment_on_lesson

  # Callbacks
  after_create :increment_student_points, if: :student_comment?

  # Scopes
  scope :recent_first, -> { order(created_at: :desc) }

  private

  def user_can_comment_on_lesson
    return unless user.present? && lesson.present?
    return if user.teacher?
    return if user == lesson.assigned_to

    errors.add(:base, "You cannot comment on this lesson")
  end

  def student_comment?
    user.student?
  end

  def increment_student_points
    user.increment_points!(3) # 3 points for commenting on a lesson
  end
end 