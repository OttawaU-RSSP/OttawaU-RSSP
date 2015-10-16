class IntakeFormsController < ApplicationController
  def new
    render locals: { intake_form: IntakeForm.new }
  end

  def create
    intake_form = IntakeForm.new(intake_form_params)

    if intake_form.save
      redirect_to root_path
    else
      render :new, locals: { intake_form: intake_form }
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
