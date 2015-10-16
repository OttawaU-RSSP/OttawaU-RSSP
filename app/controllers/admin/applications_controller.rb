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

  def assign
    application = Application.find(params[:id])
    lawyer = Lawyer.find_by(id: params[:user_id])

    respond_to do |format|
      if lawyer && application.assign(lawyer)
        format.html { redirect_to admin_application_path(application), notice: 'Successfully assigned lawyer.' }
      else
        format.html { redirect_to admin_application_path(application), flash: { error: 'Failed to assign lawyer' } }
      end
    end
  end
end
