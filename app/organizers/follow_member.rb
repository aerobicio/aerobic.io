# An Organizer that handles the process of following another member.
#
class FollowMember
  include Interactor::Organizer

  organize CreateFollowing,
           AddFollowingToActivityFeeds
end
