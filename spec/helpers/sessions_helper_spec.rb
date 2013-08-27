require_relative "../../app/helpers/sessions_helper"

describe "SessionsHelper::NewSessionView" do
  let(:new_session_view) { SessionsHelper::NewSessionView.new(switch_board) }

  let(:switch_board) { double(:switch_board) }

  describe "#sign_up_active?" do
    subject { new_session_view.sign_up_active? }

    context "when sign up feature flip is on" do
      before do
        switch_board.should_receive(:sign_up_active?) { true }
      end

      it { should be_true }
    end

    context "when sign up feature flip is off" do
      before do
        switch_board.should_receive(:sign_up_active?) { false }
      end

      it { should be_false }
    end
  end
end
