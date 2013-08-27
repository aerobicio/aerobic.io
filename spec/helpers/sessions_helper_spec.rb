require_relative "../../app/helpers/sessions_helper"

describe "SessionsHelper::NewSessionView" do
  let(:new_session_view) { SessionsHelper::NewSessionView.new(rollout) }

  let(:rollout) { double(:rollout) }

  describe "#sign_up_active?" do
    subject { new_session_view.sign_up_active? }

    context "when sign up feature flip is on" do
      before do
        rollout.should_receive(:active?).with(:sign_up) { true }
      end

      it { should be_true }
    end

    context "when sign up feature flip is off" do
      before do
        rollout.should_receive(:active?).with(:sign_up) { false }
      end

      it { should be_false }
    end
  end
end
