require_relative "../../app/helpers/identities_helper"

describe "IdentitiesHelper::NewIdentityView" do
  let(:new_identity_view) { IdentitiesHelper::NewIdentityView.new(identity) }

  context "when identity is nil" do
    let(:identity) { nil }

    describe "email" do
      subject { new_identity_view.email }

      it { should be_nil }
    end

    describe "errors?" do
      subject { new_identity_view.errors? }

      it { should be_false }
    end

    describe "error_count" do
      subject { new_identity_view.error_count }

      it { should == 0 }
    end

    describe "full_messages" do
      subject { new_identity_view.full_messages }

      it { should == [] }
    end

    describe "name" do
      subject { new_identity_view.name }

      it { should be_nil }
    end
  end

  context "when identity is set" do
    let(:identity) { double(:identity,  name: name,
                                        email: email,
                                        errors: errors,
                           ) }
    let(:name) { "name" }
    let(:email) { "email" }
    let(:errors) { [] }

    describe "email" do
      subject { new_identity_view.email }

      it { should == email }
    end

    describe "errors?" do
      subject { new_identity_view.errors? }

      it { should be_false }
    end

    describe "error_count" do
      subject { new_identity_view.error_count }

      it { should == 0 }
    end

    describe "full_messages" do
      subject { new_identity_view.full_messages }

      it { should == [] }
    end

    describe "name" do
      subject { new_identity_view.name }

      it { should == name }
    end

    context "and has errors" do
      let(:errors) { double(:errors,  any?: true,
                                      count: count,
                                      full_messages: full_messages,
                            ) }
      let(:count) { 2 }
      let(:full_messages) { [1,2] }

      describe "errors?" do
        subject { new_identity_view.errors? }

        it { should be_true }
      end

      describe "error_count" do
        subject { new_identity_view.error_count }

        it { should == count }
      end

      describe "full_messages" do
        subject { new_identity_view.full_messages }

        it { should == full_messages }
      end
    end
  end
end
