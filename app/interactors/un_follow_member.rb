class UnFollowMember
  include Interactor::Organizer

  organize DeleteFollowing,
           AddUnFollowingToActivityFeeds
end
