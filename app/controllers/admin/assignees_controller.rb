class Admin::AssigneesController < AdminController
  def create
    assignee = Assignee.new(assignee_params)

    respond_to do |format|
      if assignee.save
        format.html { redirect_to admin_application_path(assignee.application), notice: 'Successfully assigned lawyer.' }
      else
        format.html { redirect_to admin_application_path(assignee.application), flash: { error: 'Failed to assign lawyer' } }
      end
    end
  end

  def destroy
    assignee = Assignee.find(params[:id])
    assignee.destroy

    respond_to do |format|
      format.html { redirect_to admin_application_path(assignee.application) }
    end
  end

  private
  def assignee_params
    params.require(:assignee).permit(:application_id, :user_id)
  end
end
