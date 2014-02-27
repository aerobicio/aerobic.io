require 'interactor'

# Takes a member_id and an unfollowed_id and removes the following relationship
# between the member and the unfollowed member.
#
class DeleteFollowing
  include Interactor

  def perform
    find_members

    if member.follows?(unfollowed_member)
      delete_member_followings
      context[:notice] = "No longer following #{unfollowed_member.name}"
    else
      context[:notice] = "Could not unfollow #{unfollowed_member.name}"
      context.fail!
    end
  end

  private

  def find_members
    context[:member] = User.find(member_id)
    context[:unfollowed_member] = User.find(followed_id)
  end

  def delete_member_followings
    ActiveRecord::Base.connection.execute(delete_user_followings_sql)
  end

  def delete_user_followings_sql
    <<-SQL
      delete from users_followings
      where user_id = #{member_id}
      and following_id = #{followed_id}
    SQL
  end
end
