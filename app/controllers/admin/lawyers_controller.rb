class Admin::LawyersController < AdminController
  before_action :load_lawyer, except: [:index]

  def index
    @lawyers = Lawyer.all.order('approved ASC')

    respond_to do |format|
      format.html
    end
  end

  def approve
    @lawyer.approve unless @lawyer.approved?

    LegalMailer.account_approved(@lawyer).deliver_now

    respond_to do |format|
      format.html { redirect_to admin_lawyer_path(@lawyer), notice: 'Successfully notified lawyer.' }
    end
  end

  def destroy
    LegalMailer.account_deleted(@lawyer).deliver_now

    @lawyer.destroy

    respond_to do |format|
      format.html { redirect_to admin_lawyers_path, notice: "Successfully deleted lawyer." }
    end
  end

  def show
  end

  def add_private_notes
    lawyer_params = params.require(:lawyer).permit(:private_notes)

    if @lawyer.update_attributes(lawyer_params)
      flash[:notice] = 'Your comment has been added'
      redirect_to :back
    else
      flash[:error] = @lawyer.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private

  def load_lawyer
    @lawyer = Lawyer.find(params[:id])
  end
end
