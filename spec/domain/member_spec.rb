require "ostruct"
require_relative "../../app/domain/member"

describe Domain::Member do
  let(:user_class) { double(:user_class) }
  let(:user) { OpenStruct.new(id: 42) }

  before do
    stub_const("User", user_class)
  end

  describe ".find(id)" do
    subject(:find) { described_class.find(id) }
    let(:id) { 42 }

    before do
      user_class.should_receive(:find).with(id) { user }
    end

    it { should be_an_instance_of(Domain::Member) }
    its(:id) { should == user.id }
  end
end
