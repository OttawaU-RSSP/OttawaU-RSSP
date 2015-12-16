class LegalInternal::AssigneesController < LegalController
  def create
    application = Application.find(assignee_params[:application_id])

    if current_user.admin? || (current_user.lawyer? && User.assigned_to(application).include?(current_user))
      assignee = Assignee.new(assignee_params)

      respond_to do |format|
        if assignee.save
          format.html { redirect_to :back, notice: 'Successfully assigned lawyer/student.' }
        else
          format.html { redirect_to :back, flash: { error: 'Failed to assign lawyer/student' } }
        end
      end
    else
      format.html { redirect_to :back, flash: { error: 'You do not have permission to assign lawyer/student' } }
    end
  end

  def destroy
    assignee = Assignee.find(params[:id])

    if current_user.admin? || (current_user.lawyer? && User.assigned_to(assignee.application).include?(current_user))
      assignee.destroy

      respond_to do |format|
        format.html { redirect_to legal_internal_application_path(assignee.application), notice: "Successfully unassigned lawyer/student." }
      end
    else
      format.html { redirect_to :back, flash: { error: 'You do not have permission to unassign lawyer/student' } }
    end
  end

  private

  def assignee_params
    params.require(:assignee).permit(:application_id, :user_id)
  end
end
