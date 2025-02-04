module Student
  class BaseController < ApplicationController
    before_action :ensure_student

    private

    def ensure_student
      unless current_user&.student?
        flash[:alert] = "You must be a student to access this area."
        redirect_to root_path
      end
    end
  end
end 