# MembersController provides a restful interface onto the Member resource.
#
class MembersController < ApplicationController
  before_action :ensure_following_is_active, only: [:follow, :unfollow]

  def index
    @view = Members::Index.new(self, current_user)
  end

  def show
    @view = Members::Show.new(self, current_user, params[:id], params[:page])
  end

  def follow
    notice = perform_in_transaction do
      FollowMember.perform(follow_params)
    end

    redirect_to members_path, notice: notice
  end

  def unfollow
    notice = perform_in_transaction do
      UnFollowMember.perform(follow_params)
    end

    redirect_to members_path, notice: notice
  end

  private

  def follow_params
    {
      member_id: current_user.id,
      followed_id: params[:id].to_i
    }
  end

  def perform_in_transaction(&block)
    notice = nil
    ActiveRecord::Base.transaction do
      result = block.call
      notice = result.notice
      fail ActiveRecord::Rollback unless result.success?
    end
    notice
  end

  def ensure_following_is_active
    render_404 && return unless $switch_board.following_active?(current_user)
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: :not_found
  end
end
