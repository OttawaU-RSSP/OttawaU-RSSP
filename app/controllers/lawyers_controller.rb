class LawyersController < ApplicationController
  before_action :load_lawyer, only: [:show, :update_password]

  def new
    @lawyer = Lawyer.new
  end

  def create
    @lawyer = Lawyer.new(lawyer_params)
    @lawyer.approved = false
    @lawyer.password = SecureRandom.hex(32)

    if @lawyer.save
      LegalMailer.intake_received(@lawyer).deliver_now
      
      flash[:notice] = 'Your application has been submitted'
      redirect_to root_path
    else
      flash[:error] = @lawyer.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
  end

  def update_password
    if params[:lawyer][:activation_token] && params[:lawyer][:activation_token] == @lawyer.activation_token
      if params[:lawyer][:password] == params[:password_confirmation]
        @lawyer.update_password params[:lawyer][:password]
        @lawyer.update_attributes(activation_token: SecureRandom.urlsafe_base64)

        sign_in @lawyer
        redirect_to lawyer_internal_root_path
      else
        redirect_to :back, flash: { error: 'Password and confirmation do not match.' }
      end
    else
      redirect_to :back, flash: { error: 'Failed to update your password.' }
    end
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

  def load_lawyer
    @lawyer = Lawyer.find(params[:id])
  end
end
