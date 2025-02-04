module Teacher
  class BaseController < ApplicationController
    before_action :ensure_teacher

    private

    def ensure_teacher
      unless current_user&.teacher?
        flash[:alert] = "You must be a teacher to access this area."
        redirect_to root_path
      end
    end
  end
end
