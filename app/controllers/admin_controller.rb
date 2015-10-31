class AdminController < ApplicationController
  before_action :require_login, :authorize

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    @admin.approved = true
    @admin.password = SecureRandom.hex(32)

    if @admin.save
      AdminMailer.account_created(@admin).deliver_now
      flash[:notice] = "Admin has been created. They'll be notified by email"
      redirect_to admin_root_path
    else
      flash[:error] = @admin.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def admin_params
    params.require(:admin).permit(
      :name,
      :email,
    )
  end

  def authorize
    deny_access unless current_user.admin?
  end

  def url_after_denied_access_when_signed_out
    new_session_path
  end

  def url_after_denied_access_when_signed_in
    new_session_path
  end
end
