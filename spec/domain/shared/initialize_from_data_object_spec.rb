require "spec_helper"
require "ostruct"
require_relative "../../../app/domain/shared/initialize_from_data_object"

class TestDomainObject
  include Domain::Shared::InitializeFromDataObject

  attr_reader :id
  attr_accessor :active_duration
end

class FakeParamsHash
  def initialize(hash = {})
    @permitted = false
    @hash = hash
  end

  def to_h
    @hash
  end

  def each(&block)
    @hash.each(&block)
  end

  def permitted?
    @permitted
  end

  def sanitize
    @permitted = true
  end
end

describe TestDomainObject do
  subject(:attribute_assignment) { described_class.new(data_object) }

  context "when given a hash" do
    let(:data_object) { { id: 42, active_duration: "lol" } }

    its(:id) { should == 42 }
    its(:active_duration) { should == "lol" }
  end

  context "when given an ActiveRecord object" do
    let(:data_object) { FactoryGirl.build(:workout) }

    its(:id) { should == data_object.id }
    its(:active_duration) { should == data_object.active_duration }
  end

  context "when given an OpenStruct object" do
    let(:data_object) { OpenStruct.new(id: 42, active_duration: "lol") }

    its(:id) { should == 42 }
    its(:active_duration) { should == "lol" }
  end

  context "when given a JSON string" do
    let(:data_object) { %!{ "id": 42, "active_duration": "lol" }! }

    its(:id) { should == 42 }
    its(:active_duration) { should == "lol" }
  end

  context "when given a params hash" do
    let(:data_object) { FakeParamsHash.new(id: 42, active_duration: "lol") }

    context "that has been sanitized" do
      before do
        data_object.sanitize
      end

      its(:id) { should == 42 }
      its(:active_duration) { should == "lol" }
    end

    context "that has not been santitized" do
      it "should raise an ActiveModel::ForbiddenAttributes error" do
        expect { attribute_assignment }
          .to raise_error(ActiveModel::ForbiddenAttributesError)
      end
    end
  end
end
