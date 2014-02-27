unless defined?(ActiveRecord)
  require 'active_record'
  require 'factory_girl'
  require 'shoulda-matchers'

  require_relative 'factories/authentication'
  require_relative 'factories/identity'
  require_relative 'factories/user'
  require_relative 'factories/workouts'

  dbconfig = YAML.load(File.open('config/database.yml'))
  ActiveRecord::Base.establish_connection(dbconfig['test'])

  RSpec.configure do |config|
    config.around do |example|
      ActiveRecord::Base.transaction do
        example.run
        fail ActiveRecord::Rollback
      end
    end
  end
end
