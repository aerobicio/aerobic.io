# MembersController provides a restful interface onto the Member resource.
#
class MembersController < ApplicationController
  before_filter :ensure_following_is_active, only: [:follow, :unfollow]
  before_filter :find_member, only: [:show, :follow, :unfollow]

  def index
    @members = Domain::Member.all
    @member = @members.delete_if { |member| member.id == current_user.id }
  end

  def show
    @activities = Activity.all.where(activity_user_id: current_user.id)
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
    unless $switch_board.following_active?
       render_404 and return
    end
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end

  def find_member
    @member = Domain::Member.find(params[:id])
  end
end
