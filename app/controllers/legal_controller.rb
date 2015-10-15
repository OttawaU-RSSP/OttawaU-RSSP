class LegalController < ApplicationController
  before_action :require_login, :authorize

  private
  def authorize
    deny_access unless current_user.lawyer? && current_user.approved?
  end

  def url_after_denied_access_when_signed_out
    new_legal_session_path
  end

  def url_after_denied_access_when_signed_in
    new_legal_session_path
  end
end
