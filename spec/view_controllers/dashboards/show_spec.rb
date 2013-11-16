require_relative "../../../app/view_controllers/dashboards/show"

describe Dashboards::Show do
  let(:view) { described_class.new(controller, member) }
  let(:controller) { double(:controller) }
  let(:member) { double(:member, activities: member_activities) }
  let(:member_activities) { [activity_1, activity_2] }
  let(:activity_1) { double(:activity_1, cache_key: 1) }
  let(:activity_2) { double(:activity_2, cache_key: 2) }

  describe "#cache_key" do
    subject(:cache_key) { view.cache_key }

    it "should be a concatination of the members activities cache keys" do
      cache_key.should == "1:2"
    end
  end

  describe "#activities" do
    subject(:activities) { view.activities }

    it "should return the members activities" do
      activities.should == member_activities
    end

    it "should be memoised" do
      member.should_receive(:activities).once
      activities
      activities
      activities
    end
  end

  describe "#render_activities" do
    subject(:render_activities) { view.render_activities }

    context "when the member has activities" do
      let(:member_activities) { [activity_1] }

      before do
        controller.should_receive(:render).with(member_activities) do
          ["render"]
        end
      end

      it "should render the activities" do
        render_activities.should == "render"
      end
    end

    context "whent he member has no activities" do
      let(:member_activities) { [] }

      it "should render a message stating so" do
        render_activities.should == "You have no activity!"
      end
    end
  end
end
