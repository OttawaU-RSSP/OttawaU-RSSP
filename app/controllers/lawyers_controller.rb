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

  def show
    @lawyer = Lawyer.find(params[:id])
  end

  private

  def lawyer_params
    params.require(:lawyer).permit(
      :name,
      :email,
      :other_employment_type,
      :other_area_of_practice,
      :other_area_of_interest,
      :language_interested_in_translating,
      *Lawyer.stored_attributes[:extra],
      areas_of_practice: [],
      areas_of_interest: [],
    )
  end
end
