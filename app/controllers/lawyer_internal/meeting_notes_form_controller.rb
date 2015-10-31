class Admin::MeetingNotesFormsController < ApplicationController
  before_action :load_application

  def edit
    @meeting_notes_form = MeetingNotesForm.from_application(@application)
  end

  def update
    meeting_notes_form = MeetingNotesForm.new(meeting_notes_form_params)
    meeting_notes_form.application = @application

    if meeting_notes_form.save
      redirect_to lawyer_internal_application_path(@application), notice: 'Successfully updated meeting notes.'
    else
      render :new, locals: { meeting_notes_form: meeting_notes_form }
    end
  end

  private

  def meeting_notes_form_params
    params.require(:follow_up_call_form).permit(
      :public_meeting_notes,
      :private_meeting_notes,
    )
  end

  def load_application
    @application = Application.find(params[:meeting_notes_form][:application_id])
  end
end
