class IntakeFormsController < ApplicationController
  def new
    @intake_form = IntakeForm.new
    @intake_form.application = Application.new
  end

  def create
    @intake_form = IntakeForm.new(intake_form_params)
    @intake_form.application = Application.new

    if @intake_form.save
      flash[:notice] = 'Your application has been submitted'
      redirect_to root_path
    else
      flash[:error] = @intake_form.errors.full_messages.to_sentence
      render :new
    end
  end

  def update
    intake_form = IntakeForm.new(intake_form_params)
    intake_form.application = Application.find(params[:intake_form][:application_id])

    if intake_form.save
      redirect_to legal_internal_application_path(intake_form.application), notice: 'Successfully updated.'
    else
      redirect_to legal_internal_application_path(intake_form.application), notice: 'Error updating.'
    end
  end

  private

  def intake_form_params
    params.require(:intake_form).permit(
      :name,
      :phone,
      :email,
      :address_line_1,
      :address_line_2,
      :city,
      :province,
      :postal_code,
      :citizenship_status,
      :connected_to_refugee,
      :refugee_connection_type,
      :refugee_outside_country_of_origin,
      :group_size,
      :sah_connection,
      :interpreter_needed,
      :sufficient_resources,
      :criminal_record
    )
  end
end
