class Admin::ApplicationsController < AdminController
  before_action :load_application, only: [:show, :approve_follow_up_call, :reject]

  def index
    @applications = Application.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @intake_form = IntakeForm.from_application(@application)
    @follow_up_call_form = FollowUpCallForm.from_application(@application)
    @meeting_notes_form = MeetingNotesForm.from_application(@application)

    respond_to do |format|
      format.html
    end
  end

  def approve_follow_up_call
    @application.accept_follow_up!

    redirect_to admin_application_path(@application), notice: 'Follow up call approved.'
  end

  def reject
    @application.reject

    redirect_to admin_application_path(@application), notice: 'Application rejected.'
  end

  private

  def load_application
    @application = Application.find(params[:id])
  end
end
