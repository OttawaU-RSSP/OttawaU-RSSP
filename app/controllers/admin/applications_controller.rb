class Admin::ApplicationsController < AdminController
  def index
    @applications = Application.all
    @students = Student.all
    @lawyers = Lawyer.all

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
