module Legal::ApplicationsHelper
  def application_path(user, application)
    if user.lawyer?
      lawyer_internal_application_path(application)
    elsif user.student?
      student_internal_application_path(application)
    elsif user.admin?
      admin_application_path(application)
    end
  end
end
