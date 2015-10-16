class Admin::ApplicationsController < AdminController
  def index
    @applications = Application.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @application = Application.find(params[:id])
    @intake_form = IntakeForm.from_application(@application)

    respond_to do |format|
      format.html
    end
  end
end
