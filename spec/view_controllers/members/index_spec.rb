require_relative "../../../app/view_controllers/members/index"

describe Members::Index do
  let(:view) { described_class.new(controller, member) }
  let(:controller) { double(:controller) }
  let(:member) { double(:member, id: 1, cache_key: "1") }
  let(:members) { double(:members) }
  let(:other_members) { [member_1, member_2] }
  let(:member_1) { double(:member_1, cache_key: "o1") }
  let(:member_2) { double(:member_2, cache_key: "o2") }

  before do
    stub_const("User", Class.new)
    User.should_receive(:where) { members }
    members.should_receive(:not).with(:id => member.id) { other_members }
  end

  describe "#cache_key" do
    subject(:cache_key) { view.cache_key }

    it "should be a combination of the members cached keys" do
      cache_key.should == "1:o1:o2"
    end
  end

  describe "#render_other_members" do
    subject(:render_other_members) { view.render_other_members }

    it "should render other members" do
      controller.should_receive(:render).with(other_members) { ["render"] }
      render_other_members.should == "render"
    end
  end
end
