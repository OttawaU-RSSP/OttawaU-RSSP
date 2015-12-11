class LegalInternal::FollowUpCallFormsController < LegalController
  def edit
    @application = Application.find(params[:application_id])
    @follow_up_call_form = FollowUpCallForm.from_application(@application)
    @intake_form = IntakeForm.from_application(@application)
  end

  def update
    @application = Application.find(params[:follow_up_call_form][:application_id])

    follow_up_call_form = FollowUpCallForm.new(follow_up_call_form_params)
    follow_up_call_form.application = @application

    if follow_up_call_form.save
      redirect_to legal_internal_application_path(@application), notice: 'Successfully updated.'
    else
      render :new, locals: { follow_up_call_form: follow_up_call_form }
    end
  end

  private

  def follow_up_call_form_params
    params.require(:follow_up_call_form).permit(
      :public_notes,
      :private_notes,
      :proper_group_size,
      :refugee_nationality,
      :refugee_current_location,
      :connect_refugee_family_in_canada,
      :add_to_refugee_assistance_list,
    )
  end
end
