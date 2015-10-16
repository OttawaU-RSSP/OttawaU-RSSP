class SessionsController < LegalController
  skip_before_filter :require_login, only: [:create, :new, :destroy]
  skip_before_filter :authorize, only: [:create, :new, :destroy]

  def new
  end

  def create
    user = authenticate(params)

    sign_in(user) do |status|
      if status.success?
        if user.lawyer?
          redirect_back_or lawyer_internal_root_path
        elsif user.student?
          redirect_back_or student_internal_root_path
        elsif user.admin?
          redirect_back_or admin_root_path
        end
      else
        flash.now.notice = status.failure_message
        render action: :new, status: :unauthorized
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
