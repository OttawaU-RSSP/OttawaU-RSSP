class SponsorsController < ApplicationController
  before_action :load_sponsor, only: [:show, :update_password]
  before_action :authorize, only: [:show]

  def show
    @sponsor_group = SponsorGroup.find(@sponsor.sponsor_group_id)
    @application = @sponsor_group.application
  end

  def update_password
    if params[:sponsor][:activation_token] && params[:sponsor][:activation_token] == @sponsor.activation_token
      if params[:sponsor][:password] == params[:password_confirmation]
        @sponsor.update_password params[:sponsor][:password]
        @sponsor.update_attributes(activation_token: SecureRandom.urlsafe_base64)

        sign_in @sponsor
        redirect_to sponsor_path(@sponsor)
      else
        redirect_to :back, flash: { error: 'Password and confirmation do not match.' }
      end
    else
      redirect_to :back, flash: { error: 'Failed to update your password.' }
    end
  end

  private

  def load_sponsor
    @sponsor = Sponsor.find(params[:id])
  end

  def sponsor_params
    params.require(:sponsor).permit(
      :name,
      :email,
      *Sponsor.stored_attributes[:extra],
    )
  end

  def authorize
    deny_access unless current_user && current_user.sponsor? && current_user == @sponsor
  end

  def url_after_denied_access_when_signed_out
    new_session_path
  end

  def url_after_denied_access_when_signed_in
    new_session_path
  end
end
