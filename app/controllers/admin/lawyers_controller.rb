class Admin::LawyersController < AdminController
  def index
    @lawyers = Lawyer.all

    respond_to do |format|
      format.html
    end
  end

  def approve
    @lawyer = Lawyer.find(params[:id])
    @lawyer.approve

    respond_to do |format|
      format.html { redirect_to admin_lawyers_path, notice: 'Successfully approved lawyer.' }
    end
  end

  def show
    @lawyer = Lawyer.find(params[:id])
  end
end
