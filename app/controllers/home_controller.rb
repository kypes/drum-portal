class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    if user_signed_in?
      redirect_to current_user.teacher? ? teacher_root_path : student_root_path
    end
  end
end
