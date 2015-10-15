class IntakeFormsController < ApplicationController
  def new
  end

  def create
    sponsor_group = SponsorGroup.create(sponsor_group_params)

    if sponsor_group.persisted?
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def sponsor_group_params
    @sponsor_group_params ||= params.require(:intake_form).permit(
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
