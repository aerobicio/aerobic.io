unless Rails.env.production?
  require 'consistency_fail/enforcer'
  ConsistencyFail::Enforcer.enforce!
end
