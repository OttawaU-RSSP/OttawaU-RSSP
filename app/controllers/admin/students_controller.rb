class Admin::StudentsController < AdminController
  def index
    @students = Student.all

    respond_to do |format|
      format.html
    end
  end

  def approve
    @student = Student.find(params[:id])
    @student.approve

    respond_to do |format|
      format.html { redirect_to admin_students_path, notice: 'Successfully approved student.' }
    end
  end

  def show
    @student = Student.find(params[:id])
  end
end
