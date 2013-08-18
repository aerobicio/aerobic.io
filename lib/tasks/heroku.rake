# This will suppress the error on heroku when trying to run pg_dump after
# running migrations:
#   rake aborted!
#   Error dumping database
# 
# Solution from:
#   http://stackoverflow.com/questions/17300341/migrate-not-working-on-heroku
#
if Rails.env == 'production'
  Rake::Task["db:structure:dump"].clear
end
