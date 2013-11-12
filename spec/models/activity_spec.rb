require "active_record_helper"
require_relative "../support/shared/activity_spec"
require_relative "../../app/models/activity"

describe Activity do
  it_should_behave_like "an activity model"

  describe "an activity models public API" do
    describe "description" do
      subject(:description) { described_class.new.description }

      it "should not raise an UnimplementedMethodError" do
        expect { description }.to raise_error(NoMethodError)
      end
    end
  end
end
