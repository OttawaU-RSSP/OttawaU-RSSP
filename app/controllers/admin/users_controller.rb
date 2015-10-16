class Admin::UsersController < AdminController
  def index
    @users = User.all

    respond_to do |format|
      format.html
    end
  end

  def approve
    @user = User.find(params[:id])
    @user.approve

    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: 'Successfully approved user.' }
    end
  end
end
