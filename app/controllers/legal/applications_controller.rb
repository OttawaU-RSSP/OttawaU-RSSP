class Legal::ApplicationsController < LegalController
  def index
    @applications = Application.all

    respond_to do |format|
      format.html
    end
  end
end
