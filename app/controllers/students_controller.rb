class StudentsController < ApplicationController
  before_action :load_student, only: [:show, :update_password]

  def new
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    @student.approved = false
    @student.password = SecureRandom.hex(32)

    if @student.save
      LegalMailer.intake_received(@student).deliver_now

      flash[:notice] = 'Your application has been submitted'
      redirect_to root_path
    else
      flash[:error] = @student.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
  end

  def update_password
    if params[:student][:activation_token] && params[:student][:activation_token] == @student.activation_token
      if params[:student][:password] == params[:password_confirmation]
        @student.update_password params[:student][:password]
        @student.update_attributes(activation_token: SecureRandom.urlsafe_base64)

        sign_in @student
        redirect_to student_internal_root_path
      else
        redirect_to :back, flash: { error: 'Password and confirmation do not match.' }
      end
    else
      redirect_to :back, flash: { error: 'Failed to update your password.' }
    end
  end

  private

  def load_student
    @student = Student.find(params[:id])
  end

  def student_params
    params.require(:student).permit(
      :name,
      :email,
      *Student.stored_attributes[:extra],
    )
  end
end
