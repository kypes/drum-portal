class CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.teacher? || record.lesson.assigned_to_id == user.id
  end

  def destroy?
    user.teacher? || record.user_id == user.id
  end
end 