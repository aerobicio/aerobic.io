require_relative "../../app/helpers/avatar_helper"

include AvatarHelper

describe AvatarHelper do
  describe "#gravatar_for_member" do
    subject { gravatar_for_member(member, options) }

    let(:member) { double(email: "justin@pixelbloom.com") }
    let(:options) { {} }

    it { should == "<figure class=\"avatar\"><img alt=\"4914f38406ec528bebfc1f8248e1cf17\" class=\"avatar__image\" src=\"http://gravatar.com/avatar/4914f38406ec528bebfc1f8248e1cf17.png?s=64\" /></figure>" }

    describe "options" do
      describe "when I pass in extra css classes" do
        let(:options) { {extra_classes: "velociraptors-are-awesome"} }
        it { should == "<figure class=\"avatar velociraptors-are-awesome\"><img alt=\"4914f38406ec528bebfc1f8248e1cf17\" class=\"avatar__image\" src=\"http://gravatar.com/avatar/4914f38406ec528bebfc1f8248e1cf17.png?s=64\" /></figure>" }
      end

      describe "when I pass in a different size option" do
        let(:options) { {size: :large} }
        it { should == "<figure class=\"avatar--large\"><img alt=\"4914f38406ec528bebfc1f8248e1cf17\" class=\"avatar__image\" src=\"http://gravatar.com/avatar/4914f38406ec528bebfc1f8248e1cf17.png?s=164\" /></figure>" }
      end
    end
  end
end
