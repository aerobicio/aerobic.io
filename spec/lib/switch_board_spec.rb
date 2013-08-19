require_relative "../../lib/switch_board"

describe SwitchBoard do
  let(:feature_flip) { SwitchBoard.new(rollout) }
  let(:rollout) { double(:rollout) }

  SwitchBoard::FEATURE_FLIPS.each do |flip|
    describe "activate_#{flip}" do
      subject(:activate) { feature_flip.send("activate_#{flip}".to_sym) }

      before do
        rollout.should_receive(:activate).with(flip) { "OK" }
      end

      it "should activate the feature flip" do
        activate.should == "OK"
      end
    end

    describe "deactivate_#{flip}" do
      subject(:deactivate) { feature_flip.send("deactivate_#{flip}".to_sym) }

      before do
        rollout.should_receive(:deactivate).with(flip) { "OK" }
      end

      it "should deactivate the feature flip" do
        deactivate.should == "OK"
      end
    end

    describe "#{flip}_is_active?" do
      subject(:is_active) { feature_flip.send("#{flip}_is_active?".to_sym) }

      before do
        rollout.should_receive(:active?).with(flip) { true }
      end

      it "should return true if the flip is active" do
        is_active.should == true
      end
    end
  end
end
