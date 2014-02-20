require_relative "../../app/interactors/process_uploaded_fit_file"
require_relative "../support/uploaded_activity"

describe ProcessUploadedFitFile do
  let(:fit_file) { double(:fit_file) }

  before do
    stub_const("FitFile", Class.new)
  end

  describe "#perform" do
    subject(:result) { described_class.perform(context) }

    describe "with activity" do
      let(:context) do
        {
          activity: uploaded_activity,
        }
      end

      before do
        FitFile.should_receive(:new) { fit_file }
      end

      it "should be marked as successful" do
        result.success?.should be_true
      end

      it "should add fit_file to the context" do
        result.fitfile.should == fit_file
      end
    end

    describe "without activity" do
      let(:context) do
        {}
      end

      it "returns a notice if activity is not passed in" do
        result.notice.should == "No Fit File found"
      end
    end
  end
end
