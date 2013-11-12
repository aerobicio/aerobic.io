# MembersController provides a restful interface onto the Member resource.
#
class MembersController < ApplicationController
  before_filter :ensure_following_is_active, only: [:follow, :unfollow]

  def index
    @members = User.all
    @member = @members.delete_if { |member| member.id == current_user.id }
  end

  def show
    @member = User.find(params[:id])
    @activities = @member.activities
  end

  def follow
    notice = nil

    ActiveRecord::Base.transaction do
      result = FollowMember.perform(follow_params)
      notice = result.notice
      raise ActiveRecord::Rollback unless result.success?
    end

    redirect_to members_path, notice: notice
  end

  def unfollow
    notice = nil

    ActiveRecord::Base.transaction do
      result = UnFollowMember.perform(follow_params)
      notice = result.notice
      raise ActiveRecord::Rollback unless result.success?
    end

    redirect_to members_path, notice: notice
  end

  private

  def follow_params
    {
      member_id: current_user.id,
      followed_id: params[:id],
    }
  end

  def ensure_following_is_active
    unless $switch_board.following_active?
       render_404 and return
    end
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end
end
