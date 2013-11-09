# MembersController provides a restful interface onto the Member resource.
#
class MembersController < ApplicationController
  before_filter :ensure_following_is_active

  def index
    @members = Domain::Member.all
    @member = @members.delete_if { |member| member.id == current_user.id }
  end

  def follow
    result = FollowMember.perform(member_id: current_user.id,
                                  followed_id: params[:id])

    redirect_to members_path, notice: result.notice
  end

  def unfollow
    result = UnFollowMember.perform(member_id: current_user.id,
                                    unfollowed_id: params[:id])

    redirect_to members_path, notice: result.notice
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
end
