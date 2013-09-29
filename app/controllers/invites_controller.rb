class InvitesController < ApplicationController
  before_action :require_user

  def new
    @invite = Invite.new
  end

  def create
    @invite = Invite.create(invite_params)
    if @invite.save
      redirect_to new_invite_path
      flash[:success] = "Invitiation successfully sent!"
      AppMailer.delay.invitation_email(@invite)
    else
      render :new
    end
  end


  private

  def invite_params
    params.require(:invite).permit(:invitee_name, :invitee_email, :message).merge!(inviter_id: current_user.id)
  end

end
