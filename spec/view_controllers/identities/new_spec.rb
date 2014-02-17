require_relative '../../../app/view_controllers/identities/new'

describe Identities::New do
  let(:view) { described_class.new(controller, identity) }
  let(:controller) { double(:controller) }

  context 'when no identity is given' do
    let(:identity) { nil }

    describe 'cache_key' do
      subject { view.cache_key }

      it { should == '::[]' }
    end

    describe 'email' do
      subject { view.email }

      it { should be_nil }
    end

    describe 'errors?' do
      subject { view.errors? }

      it { should be_false }
    end

    describe 'error_count' do
      subject { view.error_count }

      it { should == 0 }
    end

    describe 'full_messages' do
      subject { view.full_messages }

      it { should == [] }
    end

    describe 'name' do
      subject { view.name }

      it { should be_nil }
    end

    describe 'render_errors' do
      subject { view.render_errors }

      it { should be_nil }
    end
  end

  context 'when identity is set' do
    let(:identity) do double(:identity,  name: name,
                                         email: email,
                                         errors: errors,
                           ) end
    let(:name) { 'name' }
    let(:email) { 'email' }
    let(:errors) { [] }

    describe 'cache_key' do
      subject { view.cache_key }

      it { should == "#{name}:#{email}:[]" }
    end

    describe 'email' do
      subject { view.email }

      it { should == email }
    end

    describe 'errors?' do
      subject { view.errors? }

      it { should be_false }
    end

    describe 'error_count' do
      subject { view.error_count }

      it { should == 0 }
    end

    describe 'full_messages' do
      subject { view.full_messages }

      it { should == [] }
    end

    describe 'name' do
      subject { view.name }

      it { should == name }
    end

    describe 'render_errors' do
      subject { view.render_errors }

      it { should be_nil }
    end

    context 'and has errors' do
      let(:errors) do double(:errors,  any?: true,
                                       count: count,
                                       full_messages: full_messages,
                            ) end
      let(:count) { 2 }
      let(:full_messages) { [1, 2] }

      describe 'cache_key' do
        subject { view.cache_key }

        it { should == "#{name}:#{email}:#{full_messages}" }
      end

      describe 'errors?' do
        subject { view.errors? }

        it { should be_true }
      end

      describe 'error_count' do
        subject { view.error_count }

        it { should == count }
      end

      describe 'full_messages' do
        subject { view.full_messages }

        it { should == full_messages }
      end

      describe 'render_errors' do
        subject { view.render_errors }

        let(:render_params) do
          {
            partial: 'identities/form_errors',
            locals: { view: view },
          }
        end

        before do
          controller.should_receive(:render).with(render_params) { ['render'] }
        end

        it { should == 'render' }
      end
    end
  end
end
