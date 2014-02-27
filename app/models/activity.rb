# Activity is the SuperClass of all objects that appear in a users activity
# feed on their dashboard. It defines a public API that Activity subclasses
# should implement.
#
# See spec/support/shared/activity_spec.rb for the public API.
#
class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :activity_workout, class_name: 'Workout'
  belongs_to :activity_user, class_name: 'User'
  belongs_to :activity_followed_user, class_name: 'User'

  validates :user, presence: true

  default_scope { order(created_at: :desc) }

  scope :exclude_following, lambda {
    where.not(type: ['Activity::FollowedUser', 'Activity::UnfollowedUser'])
  }

  def date
    created_at.try(:to_date)
  end
end
