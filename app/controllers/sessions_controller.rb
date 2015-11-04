class SessionsController < LegalController
  skip_before_filter :require_login, only: [:create, :new, :destroy, :activate]
  skip_before_filter :authorize, only: [:create, :new, :destroy, :activate]

  def new
  end

  def create
    user = authenticate(params)

    if user
      sign_in(user) do |status|
        if status.success?
          if user.lawyer?
            redirect_back_or lawyer_internal_root_path
          elsif user.student?
            redirect_back_or student_internal_root_path
          elsif user.admin?
            redirect_back_or admin_root_path
          elsif user.sponsor?
            redirect_back_or sponsor_path(user)
          end
        else
          flash.now.notice = status.failure_message
          render action: :new, status: :unauthorized
        end
      end
    else
      flash.now.notice = "Invalid email/password"
      render action: :new, status: :unauthorized
    end
  end

  def activate
    token = params[:token]
    @user = User.find_by(activation_token: token)

    if @user
      @password_update_path = if @user.lawyer?
        update_password_lawyer_path(@user)
      elsif @user.student?
        update_password_student_path(@user)
      elsif @user.admin?
        update_password_admin_path(@user)
      elsif @user.sponsor?
        update_password_sponsor_path(@user)
      end
    else
      @error = "Failed to activate your account. Contact the application admin"
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
