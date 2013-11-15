# SwitchBoard is a class that provides the ability to toggle features on and
# off. It wraps the rollout gem so that we do not expose the gems API to our
# code base.
#
# This will make it easier to upgrade or change feature flipping gems in the
# future should we desire to do so.
#
# It also serves as a single place to document all known feature flips in use
# within the application.
#
class SwitchBoard
  def initialize(rollout = $rollout)
    @rollout = rollout
  end

  FEATURE_FLIPS = [:sign_up, :following]

  FEATURE_FLIPS.each do |flip_name|
    define_method "activate_#{flip_name}" do |group = :all|
      if global?(group)
        activate(flip_name)
      else
        activate_for_group(flip_name, group)
      end
    end

    define_method "deactivate_#{flip_name}" do |group = :all|
      if global?(group)
        deactivate(flip_name)
      else
        deactivate_for_group(flip_name, group)
      end
    end

    define_method "#{flip_name}_active?" do |user = nil|
      @rollout.active?(flip_name, user)
    end
  end

  private

  def global?(group)
    group == :all
  end

  def activate(flip_name)
    @rollout.activate(flip_name)
  end

  def activate_for_group(flip_name, group)
    @rollout.activate_group(flip_name, group)
  end

  def deactivate(flip_name)
    @rollout.deactivate(flip_name)
  end

  def deactivate_for_group(flip_name, group)
    @rollout.deactivate_group(flip_name, group)
  end
end
