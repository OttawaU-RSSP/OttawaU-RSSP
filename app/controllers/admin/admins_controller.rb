class Admin::AdminsController < AdminController
  before_action :load_admin, only: [:show, :update_password, :reactivate]

  def index
    @admins = Admin.all
    @new_admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    @admin.approved = true
    @admin.password = SecureRandom.hex(32)

    if @admin.save
      AdminMailer.account_created(@admin).deliver_now
      flash[:notice] = "Admin has been created. They'll be notified by email"
      redirect_to admin_admins_path
    else
      flash[:error] = @admin.errors.full_messages.to_sentence
      redirect_to admin_admins_path
    end
  end

  def show
  end

  def reactivate
    AdminMailer.account_created(@admin).deliver_now

    flash[:notice] = "Another activation email has been sent to #{@admin.name}"
    redirect_to admin_admin_path(@admin)
  end

  def update_password
    if params[:admin][:activation_token] && params[:admin][:activation_token] == @admin.activation_token
      if params[:admin][:password] == params[:password_confirmation]
        @admin.update_password params[:admin][:password]
        @admin.update_attributes(activation_token: SecureRandom.urlsafe_base64)

        sign_in @admin
        redirect_to admin_root_path
      else
        redirect_to :back, flash: { error: 'Password and confirmation do not match.' }
      end
    else
      redirect_to :back, flash: { error: 'Failed to update your password.' }
    end
  end

  private

  def admin_params
    params.require(:admin).permit(
      :name,
      :email,
    )
  end

  def load_admin
    @admin = Admin.find(params[:id])
  end
end
