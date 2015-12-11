class Admin::ApplicationsController < AdminController
  before_action :load_application, only: [:show, :approve_follow_up_call, :approve_intake_form, :reject, :destroy]

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

  def destroy
    @application.sponsor_group.destroy

    respond_to do |format|
      format.html { redirect_to admin_applications_path, notice: "Successfully deleted application." }
    end
  end

  def approve_follow_up_call
    if @application.followed_up?
      @application.accept_follow_up!
      primary_sponsor = Sponsor.create_from_sponsor_group(@application.sponsor_group)
      SponsorGroupMailer.follow_up_call_form_approved(primary_sponsor).deliver_now
      redirect_to admin_application_path(@application), notice: 'Intake discussion approved.'
    else
      redirect_to admin_application_path(@application), flash: { error: "Failed to approve intake discussion. Application cannot transition from #{@application.state.humanize(capitalize: false)} to in progress" }
    end
  end

  def approve_intake_form
    if @application.intake?
      @application.intaken!
      SponsorGroupMailer.intake_form_approved(@application.sponsor_group).deliver_now
      redirect_to admin_application_path(@application), notice: 'Intake form approved.'
    else
      redirect_to admin_application_path(@application), flash: { error: "Failed to approve intake form. Application cannot transition from #{@application.state.humanize(capitalize: false)} to pending follow up" }
    end
  end

  def reject
    @application.reject
    @application.sponsor_group.destroy

    redirect_to admin_applications_path, notice: 'Application rejected.'
  end

  private

  def load_application
    @application = Application.find(params[:id])
  end
end
