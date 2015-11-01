class Admin::LawyersController < AdminController
  before_action :load_lawyer, except: [:index]

  def index
    @lawyers = Lawyer.paginate(page: params[:page], per_page: 10).order('approved ASC')

    respond_to do |format|
      format.html
    end
  end

  def approve
    @lawyer.approve

    respond_to do |format|
      format.html { redirect_to admin_lawyers_path, notice: 'Successfully approved lawyer.' }
    end
  end

  def show
  end

  def add_comments
    lawyer_params = params.require(:lawyer).permit(:comments)

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
