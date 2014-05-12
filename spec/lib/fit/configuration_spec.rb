require 'fit/client'

describe Fit::Client do
  describe '#api_token' do
    subject { Fit::Client.api_token }

    before do
      Fit::Client.api_token = 'lol'
    end

    it { subject.should eql('lol') }
  end

  describe '#service_host' do
    subject { Fit::Client.service_host }

    before do
      Fit::Client.service_host = 'lol'
    end

    it { subject.should eql('lol') }
  end

  describe '#service_port' do
    subject { Fit::Client.service_port }

    before do
      Fit::Client.service_port = 'lol'
    end

    it { subject.should eql('lol') }
  end

  describe '#use_ssl' do
    subject { Fit::Client.use_ssl }

    before do
      Fit::Client.use_ssl = 'lol'
    end

    it { subject.should eql('lol') }
  end
end
