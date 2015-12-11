module Legal::ApplicationsHelper
  def application_path(user, application)
    if user.lawyer?
      legal_internal_application_path(application)
    elsif user.student?
      legal_internal_application_path(application)
    elsif user.admin?
      legal_internal_application_path(application)
    end
  end
end
