class Legal::ApplicationsController < LegalController
  def index
    @applications = current_user.applications

    respond_to do |format|
      format.html
    end
  end
end
