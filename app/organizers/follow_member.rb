class FollowMember
  include Interactor::Organizer

  organize CreateFollowing,
           AddFollowingToActivityFeeds
end
