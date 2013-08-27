# Load a redis instance from a local configuration file
#

if ENV["REDISCLOUD_URL"]
  uri = URI.parse(ENV["REDISCLOUD_URL"])
  $redis = Redis.new(:host => uri.host,
                     :port => uri.port,
                     :password => uri.password)

elsif ENV["WERCKER_REDIS_HOST"] && ENV["WERCKER_REDIS_PORT"]
  $redis = Redis.new(:host => ENV["WERCKER_REDIS_HOST"],
                     :port => ENV["WERCKER_REDIS_PORT"])
else
  $redis = Redis.new
end
