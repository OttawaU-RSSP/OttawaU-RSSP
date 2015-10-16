class Legal::ApplicationsController < LegalController
  def index
    @applications = current_user.applications

    respond_to do |format|
      format.html
    end
  end

  def show
    @application = current_user.applications.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
end
