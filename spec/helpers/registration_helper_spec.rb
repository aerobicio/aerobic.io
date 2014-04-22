require 'load_paths_helper'
require 'registration_helper'

include RegistrationHelper

describe RegistrationHelper do
  describe '#registration_path' do
    subject { registration_path }

    it { should == '/auth/identity/register' }
  end
end
