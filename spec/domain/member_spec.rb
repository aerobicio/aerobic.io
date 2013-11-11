require "ostruct"
require_relative "../../app/domain/member"

describe Domain::Member do
  let(:user_class) { double(:user_class) }
  let(:user) { OpenStruct.new(id: 42, authentications: [double(uid: uid)]) }
  let(:uid) { 4 }
  let(:user_2) { OpenStruct.new(id: 22) }

  before do
    stub_const("User", user_class)
    stub_const("Identity", Class.new)
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

  describe ".all" do
    subject(:all) { described_class.all }

    before do
      user_class.should_receive(:all) { [user, user_2] }
    end

    it { should be_an_instance_of(Array) }

    it "should contain Domain::Member objects" do
      all.first.should be_an_instance_of(Domain::Member)
      all.last.should be_an_instance_of(Domain::Member)
    end
  end

  describe "#email" do
    subject(:email) { member.email }

    let(:member) { Domain::Member.new(user) }
    let(:identity) { double(:identity, email: "lol@exmaple.com") }

    before do
      User.should_receive(:find).with(user.id) { user }
      Identity.should_receive(:find).with(uid) { identity }
    end

    it "should be the email on the identity of the member" do
      email.should == identity.email
    end
  end

  describe "#follow(member)" do
    subject(:follow) { member.follow(member_2) }

    let(:member) { Domain::Member.new(user) }
    let(:member_2) { Domain::Member.new(user_2) }
    let(:following) { double(:following) }

    before do
      Domain::Following.should_receive(:new) { following }
      following.should_receive(:persist) { persist }
    end

    context "successfully" do
      let(:persist) { true }

      it { should be_true }
    end

    context "unsuccessfully" do
      let(:persist) { false }

      it { should be_false }
    end
  end
end
