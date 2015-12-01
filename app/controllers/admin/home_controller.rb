class Admin::HomeController < AdminController
  def index
    @applications_requiring_action = Application.where(state: %w(intake pending_lawyer_match))
  end
end
