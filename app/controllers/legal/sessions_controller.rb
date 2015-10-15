class Legal::SessionsController < LegalController
  skip_before_filter :require_login, only: [:create, :new, :destroy]
  skip_before_filter :authorize, only: [:create, :new, :destroy]

  def new
  end

  def create
    user = authenticate(params)

    sign_in(user) do |status|
      if status.success?
        redirect_back_or legal_applications_path
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
