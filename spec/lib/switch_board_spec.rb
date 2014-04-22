require 'switch_board'

describe SwitchBoard do
  let(:feature_flip) { SwitchBoard.new(rollout) }
  let(:rollout) { double(:rollout) }

  SwitchBoard::FEATURE_FLIPS.each do |flip|
    describe "activate_#{flip}" do
      subject(:activate) { feature_flip.send("activate_#{flip}".to_sym, group) }

      context 'for all users' do
        let(:group) { :all }

        before do
          rollout.should_receive(:activate).with(flip) { 'OK' }
        end

        it 'should activate the feature flip' do
          activate.should == 'OK'
        end
      end

      context 'for a group' do
        let(:group) { :staff }

        before do
          rollout.should_receive(:activate_group).with(flip, group) { 'OK' }
        end

        it 'should activate the feature flip' do
          activate.should == 'OK'
        end
      end
    end

    describe "deactivate_#{flip}" do
      subject(:deactivate) do
        feature_flip.send("deactivate_#{flip}".to_sym, group)
      end

      context 'for all users' do
        let(:group) { :all }

        before do
          rollout.should_receive(:deactivate).with(flip) { 'OK' }
        end

        it 'should deactivate the feature flip' do
          deactivate.should == 'OK'
        end
      end

      context 'for a group' do
        let(:group) { :staff }

        before do
          rollout.should_receive(:deactivate_group).with(flip, group) { 'OK' }
        end

        it 'should deactivate the feature flip' do
          deactivate.should == 'OK'
        end
      end
    end

    describe "#{flip}_active?" do
      subject(:active) { feature_flip.send("#{flip}_active?".to_sym, user) }

      let(:user) { double(:user) }

      before do
        rollout.should_receive(:active?).with(flip, user) { true }
      end

      it 'should return true if the flip is active' do
        active.should == true
      end
    end
  end
end
