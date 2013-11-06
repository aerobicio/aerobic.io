# MembersController provides a restful interface onto the Member resource.
#
class MembersController < ApplicationController
  def index
    if $switch_board.following_active?
      @members = Domain::Member.all
      @member = @members.delete_if { |member| member.id == current_user.id }

      render :index
    else
      render file: "#{Rails.root}/public/404.html",  status: :not_found
    end
  end

  def follow
    if $switch_board.following_active?
      member = Domain::Member.find(params[:id])
      current_user.follow(member)
      redirect_to members_path, notice: "Now following #{member.name}"
    else
      redirect_to dashboard_path
    end
  end

  def unfollow
    if $switch_board.following_active?
      member = Domain::Member.find(params[:id])
      current_user.unfollow(member)
      redirect_to members_path, notice: "No longer following #{member.name}"
    else
      redirect_to dashboard_path
    end
  end
end
