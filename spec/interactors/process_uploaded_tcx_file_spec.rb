require_relative '../../app/interactors/process_uploaded_tcx_file'
require_relative '../support/uploaded_activity'

describe ProcessUploadedTcxFile do
  let(:tcxfile) { double(:tcxfile) }

  before do
    stub_const('TcxFile', Class.new)
  end

  describe '#perform' do
    subject(:result) { described_class.perform(context) }

    describe 'with activity' do
      let(:context) do
        {
          activity: tcx_uploaded_activity,
        }
      end

      before do
        TcxFile.should_receive(:new) { tcxfile }
      end

      it 'should be marked as successful' do
        result.success?.should be_true
      end

      it 'should add tcxfile to the context' do
        result.tcxfile.should == tcxfile
      end
    end

    describe 'without activity' do
      let(:context) do
        {}
      end

      it 'returns a notice if activity is not passed in' do
        result.notice.should == 'No TCX File found'
      end
    end
  end
end
