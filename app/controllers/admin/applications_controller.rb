class Admin::ApplicationsController < AdminController
  before_action :load_application, only: [:destroy]

  def index
    @applications = Application.all

    respond_to do |format|
      format.html
    end
  end

  def destroy
    @application.sponsor_group.destroy

    respond_to do |format|
      format.html { redirect_to admin_applications_path, notice: "Successfully deleted application." }
    end
  end

  private

  def load_application
    @application = Application.find(params[:id])
  end
end
