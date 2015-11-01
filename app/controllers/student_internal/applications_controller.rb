class StudentInternal::ApplicationsController < LegalController
  before_action :authorize

  def index
    @student_applications = current_user.applications
    @applications_requiring_call = Application.pending_follow_up

    respond_to do |format|
      format.html
    end
  end

  def show
    @application = current_user.applications.find(params[:id])
    @follow_up_call_form = FollowUpCallForm.from_application(@application)
    @meeting_notes_form = MeetingNotesForm.from_application(@application)

    respond_to do |format|
      format.html
    end
  end

  private

  def authorize
    deny_access unless current_user.student? && current_user.approved?
  end
end
