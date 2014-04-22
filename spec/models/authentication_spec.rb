require 'load_paths_helper'
require 'active_record_helper'
require 'models/authentication'

describe Authentication do
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:uid) }

  describe 'uniqueness constraints' do
    before do
      FactoryGirl.create(:authentication)
    end

    it { should validate_uniqueness_of(:uid).scoped_to(:provider) }
  end

  it { should belong_to(:user) }
end
