require_relative "../../../app/view_controllers/members/show"

describe Members::Show do
  let(:view) { described_class.new(controller, current_member, member_id) }
  let(:controller) { double(:controller) }
  let(:current_member) { double(:current_member, id: 1, cache_key: "1") }
  let(:member_id) { 2 }

  let(:member) do
    double(:member,
           id: member_id,
           cache_key: member_id.to_s,
           activities: member_activities,
          )
  end

  let(:member_activities) { [activity_1, activity_2] }
  let(:activity_1) { double(:activity_1, cache_key: "a1", date: Date.today) }
  let(:activity_2) { double(:activity_2, cache_key: "a2", date: Date.today) }
  let(:following_active) { true }

  before do
    stub_const("User", Class.new)
    User.should_receive(:find).with(member_id) { member }
    $switch_board ||= Class.new
    $switch_board.stub(:following_active?) { following_active }
  end

  describe "#cache_key" do
    subject(:cache_key) { view.cache_key }

    it "should be a combination of the members cached keys" do
      cache_key.should == "1:2:a1:a2"
    end
  end

  describe "#render_activities" do
    subject(:render_activities) { view.render_activities }

    let(:render_params) do
      {
        partial: "activity/grouped",
        object: { Date.today =>  member_activities },
      }
    end

    context "when the member has activities" do
      let(:member_activities) { [activity_1] }

      context "and following is active" do
        let(:following_active) { true }

        before do
          controller.should_receive(:render).with(render_params) do
            ["render"]
          end
        end

        it "should render the activities" do
          render_activities.should == "render"
        end
      end

      context "and following is not active" do
        let(:following_active) { false }

        let(:member) { double(:member, activities: activities) }
        let(:activities) do
          double(:activities, exclude_following: member_activities)
        end

        before do
          controller.should_receive(:render).with(render_params) do
            ["render"]
          end
        end

        it "should render the activities" do
          render_activities.should == "render"
        end
      end
    end

    context "when the member has no activities" do
      let(:member_activities) { [] }

      it "should render a message stating so" do
        render_activities.should == "You have no activity!"
      end
    end
  end
end
