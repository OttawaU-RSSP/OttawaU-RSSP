class Admin::StudentsController < AdminController
  before_action :load_student, except: [:index]

  def index
    @students = Student.all.order('approved ASC')

    respond_to do |format|
      format.html
    end
  end

  def approve
    @student.approve

    LegalMailer.account_approved(@student).deliver_now

    respond_to do |format|
      format.html { redirect_to admin_students_path, notice: 'Successfully approved student.' }
    end
  end

  def destroy
    LegalMailer.account_deleted(@student).deliver_now

    @student.destroy

    respond_to do |format|
      format.html { redirect_to admin_students_path, notice: "Successfully deleted student." }
    end
  end

  def show
  end

  def add_private_notes
    student_params = params.require(:student).permit(:private_notes)

    if @student.update_attributes(student_params)
      flash[:notice] = 'Your comment has been added'
      redirect_to :back
    else
      flash[:error] = @student.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private

  def load_student
    @student = Student.find(params[:id])
  end
end
