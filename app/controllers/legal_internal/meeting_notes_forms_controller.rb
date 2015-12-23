class LegalInternal::MeetingNotesFormsController < LegalController
  def update
    @application = Application.find(params[:meeting_notes_form][:application_id])
    meeting_notes_form = MeetingNotesForm.new(meeting_notes_form_params)
    meeting_notes_form.application = @application

    if meeting_notes_form.save
      redirect_to legal_internal_application_path(@application), notice: 'Successfully updated meeting notes.'
    else
      flash[:error] = @meeting_notes_form.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private

  def meeting_notes_form_params
    params.require(:meeting_notes_form).permit(
      :public_meeting_notes,
      :private_meeting_notes,
    )
  end
end
