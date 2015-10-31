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
    respond_to do |format|
      format.html
    end
  end

  def mark_lawyer_review_passed
    @application.lawyer_review_complete!
    redirect_to lawyer_internal_application_path(@application), notice: "Lawyer review passed"
  end

  def mark_expert_review_passed
    @application.expert_review_complete!
    redirect_to lawyer_internal_application_path(@application), notice: "Expert review passed"
  end

  def mark_submitted
    @application.submit!
    redirect_to lawyer_internal_application_path(@application), notice: "Application submitted"
  end

  def mark_accepted
    @application.accept!
    redirect_to lawyer_internal_application_path(@application), notice: "Application accepted"
  end

  def mark_travel_booked
    @application.book_travel!
    redirect_to lawyer_internal_application_path(@application), notice: "Travel booked"
  end

  private

  def load_application
    @application = current_user.applications.find(params[:id])
  end

  def authorize
    deny_access unless current_user.lawyer? && current_user.approved?
  end
end
