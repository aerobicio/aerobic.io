# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
AerobicIo::Application.initialize!

require 'consistency_fail/enforcer'
ConsistencyFail::Enforcer.enforce!
