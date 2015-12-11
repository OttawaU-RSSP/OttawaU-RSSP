class LawyerInternal::ApplicationsController < LegalController
  before_action :authorize
  before_action :load_application, except: :index

  def index
    @applications = current_user.applications

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

  def mark_lawyer_review_passed
    if @application.completed?
      @application.lawyer_review_complete!
      SponsorGroupMailer.lawyer_review_passed(@application.sponsor_group).deliver_now
      redirect_to lawyer_internal_application_path(@application), notice: "Lawyer review passed"
    else
      redirect_to lawyer_internal_application_path(@application), flash: { error: "Failed to complete lawyer review. Application cannot transition from #{@application.state.humanize(capitalize: false)} to lawyer reviewed" }
    end
  end

  def mark_expert_review_passed
    if @application.lawyer_reviewed?
      @application.expert_review_complete!
      SponsorGroupMailer.expert_review_passed(@application.sponsor_group).deliver_now
      redirect_to lawyer_internal_application_path(@application), notice: "Expert review passed"
    else
      redirect_to lawyer_internal_application_path(@application), flash: { error: "Failed to complete expert review. Application cannot transition from #{@application.state.humanize(capitalize: false)} to expert reviewed" }
    end
  end

  def mark_submitted
    if @application.lawyer_reviewed? || @application.expert_reviewed?
      @application.submit!
      SponsorGroupMailer.application_submitted(@application.sponsor_group).deliver_now
      redirect_to lawyer_internal_application_path(@application), notice: "Application submitted"
    else
      redirect_to lawyer_internal_application_path(@application), flash: { error: "Failed to submit application. Application cannot transition from #{@application.state.humanize(capitalize: false)} to submitted" }
    end
  end

  def mark_accepted
    if @application.submitted?
      @application.accept!
      SponsorGroupMailer.application_accepted(@application.sponsor_group).deliver_now
      redirect_to lawyer_internal_application_path(@application), notice: "Application accepted"
    else
      redirect_to lawyer_internal_application_path(@application), flash: { error: "Failed to accept application. Application cannot transition from #{@application.state.humanize(capitalize: false)} to accepted" }
    end
  end

  private

  def load_application
    @application = current_user.applications.find(params[:id])
  end

  def authorize
    deny_access unless current_user.lawyer? && current_user.approved?
  end
end
