class AdminController < ApplicationController
  # before_action :require_login, :authorize

  private

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
