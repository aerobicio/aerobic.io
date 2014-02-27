# An Organizer that handles the process of unfollowing another member.
#
class UnFollowMember
  include Interactor::Organizer

  organize DeleteFollowing,
           AddUnFollowingToActivityFeeds
end
