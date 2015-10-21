class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student.approved = false
    @student.password = SecureRandom.hex(32)

    if @student.save
      flash[:notice] = 'Your application has been submitted'
      redirect_to root_path
    else
      flash[:error] = @student.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @student = Student.find(params[:id])
  end

  private

  def student_params
    params.require(:student).permit(
      :name,
      :email,
      *Student.stored_attributes[:extra],
    )
  end
end
