class LawyerInternal::ApplicationsController < LegalController
  before_action :authorize

  def index
    @applications = current_user.applications

    respond_to do |format|
      format.html
    end
  end

  private

  def authorize
    deny_access unless current_user.lawyer?  && current_user.approved?
  end
end
