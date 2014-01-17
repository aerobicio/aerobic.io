if defined?(ConsistencyFail)
  require 'consistency_fail/enforcer'
  ConsistencyFail::Enforcer.enforce!
end
