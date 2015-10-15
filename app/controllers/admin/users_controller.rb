class Admin::UsersController < AdminController
  def index
    @users = User.all

    respond_to do |format|
      format.html
    end
  end
end
