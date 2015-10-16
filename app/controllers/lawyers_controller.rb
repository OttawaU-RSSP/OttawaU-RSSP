class LawyersController < ApplicationController
  def new
    @lawyer = Lawyer.new
  end

  def create
    @lawyer = Lawyer.new(lawyer_params)
    @lawyer.approved = false
    @lawyer.password = SecureRandom.hex(32)

    if @lawyer.save
      flash[:notice] = 'Your application has been submitted'
      redirect_to root_path
    else
      flash[:error] = @lawyer.errors.full_messages.to_sentence
      render :new
    end
  end

  private
  def lawyer_params
    params.require(:lawyer).permit(
      :name,
      :email
    )
  end
end
