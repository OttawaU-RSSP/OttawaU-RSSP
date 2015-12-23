class LegalInternal::ApplicationsController < LegalController
  before_action :load_application
  before_action :authorize_admin, only: :approve_intake_form
  before_action :authorize

  def show
    @intake_form = IntakeForm.from_application(@application)
    @follow_up_call_form = FollowUpCallForm.from_application(@application)
    @meeting_notes_form = MeetingNotesForm.from_application(@application)

    respond_to do |format|
      format.html
    end
  end

  def approve_intake_form
    if @application.intake?
      @application.intaken!
      SponsorGroupMailer.intake_form_approved(@application.sponsor_group).deliver_now
      redirect_to :back, notice: 'Intake form approved.'
    else
      redirect_to :back, flash: { error: "Failed to approve intake form. Application cannot transition from #{@application.state.humanize(capitalize: false)} to pending follow up" }
    end
  end

  def mark_intake_discussion_complete
    if @application.pending_follow_up?
      @application.follow_up!
      redirect_to :back, notice: "Application marked as followed up"
    else
      redirect_to :back, flash: { error: "Failed to follow up application. Application cannot transition from #{@application.state.humanize(capitalize: false)} to followed up" }
    end
  end

  def approve_intake_discussion
    if @application.followed_up?
      @application.accept_follow_up!
      primary_sponsor = Sponsor.create_from_sponsor_group(@application.sponsor_group)
      SponsorGroupMailer.follow_up_call_form_approved(primary_sponsor).deliver_now
      redirect_to :back, notice: 'Intake discussion approved.'
    else
      redirect_to :back, flash: { error: "Failed to approve intake discussion. Application cannot transition from #{@application.state.humanize(capitalize: false)} to in progress" }
    end
  end

  def mark_lawyer_matched
    if @application.pending_lawyer_match?
      @application.match_lawyer!
      redirect_to :back, notice: "Application marked as lawyer matched"
    else
      redirect_to :back, flash: { error: "Failed to follow up application. Application cannot transition from #{@application.state.humanize(capitalize: false)} to lawyer matched" }
    end
  end

  def mark_completed
    if @application.in_progress?
      @application.complete!
      redirect_to :back, notice: "Application marked as complete"
    else
      redirect_to :back, flash: { error: "Failed to complete application. Application cannot transition from #{@application.state.humanize(capitalize: false)} to completed" }
    end
  end

  def mark_lawyer_review_passed
    if @application.completed?
      @application.lawyer_review_complete!
      SponsorGroupMailer.lawyer_review_passed(@application.sponsor_group).deliver_now
      redirect_to :back, notice: "Lawyer review passed"
    else
      redirect_to :back, flash: { error: "Failed to complete lawyer review. Application cannot transition from #{@application.state.humanize(capitalize: false)} to lawyer reviewed" }
    end
  end

  def mark_expert_review_passed
    if @application.lawyer_reviewed?
      @application.expert_review_complete!
      SponsorGroupMailer.expert_review_passed(@application.sponsor_group).deliver_now
      redirect_to :back, notice: "Expert review passed"
    else
      redirect_to :back, flash: { error: "Failed to complete expert review. Application cannot transition from #{@application.state.humanize(capitalize: false)} to expert reviewed" }
    end
  end

  def mark_submitted
    if @application.lawyer_reviewed? || @application.expert_reviewed?
      @application.submit!
      SponsorGroupMailer.application_submitted(@application.sponsor_group).deliver_now
      redirect_to :back, notice: "Application submitted"
    else
      redirect_to :back, flash: { error: "Failed to submit application. Application cannot transition from #{@application.state.humanize(capitalize: false)} to submitted" }
    end
  end

  def mark_accepted
    if @application.submitted?
      @application.accept!
      SponsorGroupMailer.application_accepted(@application.sponsor_group).deliver_now
      redirect_to :back, notice: "Application accepted"
    else
      redirect_to :back, flash: { error: "Failed to accept application. Application cannot transition from #{@application.state.humanize(capitalize: false)} to accepted" }
    end
  end

  def reject
    @application.reject
    @application.sponsor_group.destroy

    if current_user.admin?
      redirect_to admin_applications_path, notice: 'Application rejected.'
    elsif current_user.lawyer?
      redirect_to lawyer_internal_applications_path, notice: 'Application rejected.'
    elsif current_user.student?
      redirect_to student_internal_applications_path, notice: 'Application rejected.'
    end
  end

  private

  def load_application
    @application = Application.find(params[:id])
  end

  def authorize_admin
    deny_access unless current_user.admin?
  end

  def authorize
    deny_access unless current_user.admin? || User.assigned_to(@application).include?(current_user)
  end
end
