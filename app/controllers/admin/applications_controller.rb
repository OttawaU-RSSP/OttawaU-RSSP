class Admin::ApplicationsController < AdminController
  def index
    @applications = Application.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @application = Application.find(params[:id])

    respond_to do |format|
      format.html
    end
  end
end
