# MembersController provides a restful interface onto the Member resource.
#
class MembersController < ApplicationController
  before_filter :ensure_following_is_active
  before_filter :find_member, only: [:follow, :unfollow]

  def index
    @members = Domain::Member.all
    @member = @members.delete_if { |member| member.id == current_user.id }
  end

  def follow
    current_user.follow(@member)
    redirect_to members_path, notice: "Now following #{@member.name}"
  end

  def unfollow
    current_user.unfollow(@member)
    redirect_to members_path, notice: "No longer following #{@member.name}"
  end

  private

  def ensure_following_is_active
    redirect_to dashboard_path and return unless $switch_board.following_active?
  end

  def find_member
    @member = Domain::Member.find(params[:id])
  end
end
