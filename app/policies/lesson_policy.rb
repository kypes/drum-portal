class LessonPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.teacher?
        scope.where(teacher: user)
      else
        scope.where(assigned_to: user)
      end
    end
  end

  def index?
    true
  end

  def show?
    user.teacher? || record.assigned_to_id == user.id
  end

  def create?
    user.teacher?
  end

  def update?
    user.teacher? && record.teacher_id == user.id
  end

  def destroy?
    user.teacher? && record.teacher_id == user.id
  end

  def assign?
    user.teacher? && record.teacher_id == user.id
  end
end 