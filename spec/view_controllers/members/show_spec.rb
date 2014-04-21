require_relative '../../../app/view_controllers/members/show'

describe Members::Show do
  let(:view) { described_class.new(controller, current_member, member_id) }
  let(:controller) { double(:controller) }
  let(:current_member) { double(:current_member, id: 1, cache_key: '1') }
  let(:member_id) { 2 }

  let(:member) do
    double(:member,
           name: 'Justin',
           id: member_id,
           cache_key: member_id.to_s,
           workouts: member_workouts,
           followers: member_followers,
           followings: member_followings
          )
  end

  let(:member_workouts) { [workout_1, workout_2] }
  let(:member_followers) { [double, double, double] }
  let(:member_followings) { [double] }
  let(:workout_1) { double(:workout_1, cache_key: 'a1', date: Date.today) }
  let(:workout_2) { double(:workout_2, cache_key: 'a2', date: Date.today) }
  let(:following_active) { true }

  before do
    stub_const('User', Class.new)
    User.should_receive(:find).with(member_id) { member }
    $switch_board ||= Class.new
    $switch_board.stub(:following_active?) { following_active }
  end

  describe '#cache_key' do
    subject(:cache_key) { view.cache_key }

    it 'should be a combination of the members cached keys' do
      cache_key.should == '1:2:a1:a2'
    end
  end

  describe '#render_workouts' do
    subject(:render_workouts) { view.render_workouts }

    let(:render_params) do
      {
        partial: 'workouts/grouped',
        object: { Date.today =>  member_workouts }
      }
    end

    context 'when the member has workouts' do
      let(:member_workouts) { [workout_1] }

      before do
        controller.should_receive(:render).with(render_params) do
          ['render']
        end
      end

      it 'should render the workouts' do
        render_workouts.should == 'render'
      end
    end

    context 'when the member has no workouts' do
      let(:member_workouts) { [] }

      it 'should render a message stating so' do
        render_workouts.should == 'You have no workouts!'
      end
    end
  end

  describe '#member_title' do
    subject { view.member_title }

    context 'the current_member is the member' do
      let(:current_member) { member }

      it { should == 'You' }
    end

    context ' do
      it { should == 'Justin' }
    end
  end

  describe '#workouts_count' do
    subject { view.workouts_count }

    it { should == 2 }
  end

  describe '#follower_count' do
    subject { view.follower_count }

    it { should == 3 }
  end

  describe '#following_count' do
    subject { view.following_count }

    it { should == 1 }
  end

  describe '#workouts_path' do
    subject { view.workouts_path }

    it { should == '/members/2/workouts' }
  end

  describe '#followers_path' do
    subject { view.followers_path }

    it { should == '/members/2/followers' }
  end

  describe '#followings_path' do
    subject { view.followings_path }

    it { should == '/members/2/follows' }
  end
end
